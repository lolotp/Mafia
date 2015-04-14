module Handler.Home where

import Import

import Control.Monad.Trans.Maybe
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3,
                              withSmallInput)
import Yesod.Auth.Facebook.ServerSide (getUserAccessToken)
import Yesod.Facebook (runYesodFbT)
import Facebook

-- This is a handler function for the GET request method on the HomeR
-- resource pattern. All of your resource patterns are defined in
-- config/routes
--
-- The majority of the code you will write in Yesod lives in these handler
-- functions. You can spread them across multiple files if you are so
-- inclined, or create a single monolithic file.
getHomeR :: Handler Html
getHomeR = do
    maid <- maybeAuthId
    maybeUser <- runMaybeT $ do
        accessToken <- MaybeT $ getUserAccessToken
        lift $ runYesodFbT $ getUser (Id "me") [] $ Just accessToken
        
    (formWidget, formEnctype) <- generateFormPost sampleForm
    let submission = Nothing :: Maybe (FileInfo, Text)
        handlerName = "getHomeR" :: Text
    defaultLayout $ do
        aDomId <- newIdent
        setTitle "Welcome To Yesod!"
        $(widgetFile "homepage")

postHomeR :: Handler Html
postHomeR = do
    maid <- maybeAuthId
    maybeUser <- runMaybeT $ do
        accessToken <- MaybeT $ getUserAccessToken
        lift $ runYesodFbT $ getUser (Id "me") [] $ Just accessToken
    ((result, formWidget), formEnctype) <- runFormPost sampleForm
    let handlerName = "postHomeR" :: Text
        submission = case result of
            FormSuccess res -> Just res
            _ -> Nothing

    defaultLayout $ do
        aDomId <- newIdent
        setTitle "Welcome To Yesod!"
        $(widgetFile "homepage")

sampleForm :: Form (FileInfo, Text)
sampleForm = renderBootstrap3 BootstrapBasicForm $ (,)
    <$> fileAFormReq "Choose a file"
    <*> areq textField (withSmallInput "What's on the file?") Nothing
