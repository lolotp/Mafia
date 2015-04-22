{-# LANGUAGE ScopedTypeVariables #-}
module Handler.Games where

import Import

getGamesR :: Handler Html
getGamesR = do
    defaultLayout $ do
        aDomId <- newIdent
        setTitle "Games list"
        $(widgetFile "games")

postGamesR :: Handler TypedContent
postGamesR = do
    --Just uid <- maybeAuthId
    -- $(logInfo) "parsed submitted game"
    -- submittedGame <- requireJsonBody :: Handler Game
    -- let game = submittedGame { gameCreator = uid }
    -- gameId <- runDB $ do
    --    insert game
    let num :: Int = 42
    selectRep $ do
        provideRep $ return $ toJSON num
        
 
