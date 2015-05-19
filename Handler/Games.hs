{-# LANGUAGE ScopedTypeVariables #-}
module Handler.Games where

import Import

getGamesR :: Handler Html
getGamesR = do
    defaultLayout $ do
        --aDomId <- newIdent
        setTitle "Games list"
        $(widgetFile "games")

getGameR :: GameId -> Handler Html
getGameR gameId = do
    defaultLayout $ do
        --aDomId <- newIdent
        setTitle "Games list"
        $(widgetFile "games")

postGamesR :: Handler TypedContent
postGamesR = do
     Just uid <- maybeAuthId
     submittedGame <- requireJsonBody :: Handler Game
     let game = submittedGame { gameCreator = uid }
     _ <- runDB $ do
        insert game
     selectRep $ do
        provideRep $ return $ toJSON game
 
