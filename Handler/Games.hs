module Handler.Games where

import Import

getGamesR :: Handler Html
getGamesR = do
    defaultLayout $ do
        aDomId <- newIdent
        setTitle "Games list"
        $(widgetFile "games")

postGamesR :: Handler Html
postGamesR = do
    defaultLayout $ do
        aDomId <- newIdent
        setTitle "Games list"
        $(widgetFile "games")

