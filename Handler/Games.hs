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
    Just uid <- maybeAuthId
    submittedGame <- requireJsonBody :: Handler Game
    let game = submittedGame { gameCreator = uid }
    selectRep $ do
        provideRep $ return $ toJSON game
        
 
