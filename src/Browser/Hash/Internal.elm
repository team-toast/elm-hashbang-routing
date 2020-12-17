module Browser.Hash.Internal exposing
    ( HashType(..)
    , fixPathQuery
    , pathFromFragment
    , updateUrl
    )

import String.Extra
import Url exposing (Url)


type HashType
    = Hash
    | Hashbang


updateUrl : HashType -> Url -> Url
updateUrl hashType =
    fixPathQuery << pathFromFragment hashType


pathFromFragment : HashType -> Url -> Url
pathFromFragment hashType url =
    let
        newPath =
            let
                defaultEmpty =
                    url.fragment |> Maybe.withDefault ""
            in
            case hashType of
                Hash ->
                    defaultEmpty

                Hashbang ->
                    if String.startsWith "!" defaultEmpty then
                        String.dropLeft 1 defaultEmpty

                    else
                        defaultEmpty
    in
    { url
        | path = newPath
        , fragment = Nothing
    }


fixPathQuery : Url -> Url
fixPathQuery url =
    let
        ( newPath, newQuery ) =
            case String.split "?" url.path of
                path :: query :: _ ->
                    ( path, Just query )

                _ ->
                    ( url.path, url.query )
    in
    { url | path = newPath, query = newQuery }
