module Browser.Hashbang exposing (application)

import Browser exposing (Document, UrlRequest)
import Browser.Hash.Internal exposing (HashType(..), updateUrl)
import Browser.Navigation exposing (Key)
import Url exposing (Url)


application :
    { init : flags -> Url -> Key -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : UrlRequest -> msg
    , onUrlChange : Url -> msg
    }
    -> Program flags model msg
application config =
    Browser.application
        { init = \flags url key -> config.init flags (updateUrl Hashbang url) key
        , view = config.view
        , update = config.update
        , subscriptions = config.subscriptions
        , onUrlRequest = config.onUrlRequest
        , onUrlChange = config.onUrlChange << updateUrl Hashbang
        }
