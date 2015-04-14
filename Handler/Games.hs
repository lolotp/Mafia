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
    game <- requireJsonBody :: Handler Game
    --let game2 = game { gameUser = uid }
    selectRep $ do
        provideRep $ return $ toJSON game
        
 
