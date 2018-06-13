{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Curso where

import Import
import Database.Persist.Postgresql

getCursoR :: Handler Value
getCursoR = do
    todosCursos <- runDB $ selectList [] [Asc CursoNome]
    sendStatusJSON ok200 (object ["curso" .= todosCursos])
    
postCursoR :: Handler Value
postCursoR = do 
    curso <- requireJsonBody :: Handler Curso
    cid <- runDB $ insert curso
    sendStatusJSON created201 (object ["cursoId" .= fromSqlKey cid])


getCursoIdR :: CursoId -> Handler Value
getCursoIdR cid = do
    result <- runDB $ do
        curso <- selectList [CursoId ==. cid] []
        escola  <- mapM (get . cursoEscolaId . entityVal) curso
        return $ zip curso (catMaybes escola)
    sendStatusJSON ok200 $ object ["result" .= result]
    
putCursoIdR :: CursoId -> Handler Value
putCursoIdR cid = do
    _ <- runDB $ get404 cid
    editarCurso <- requireJsonBody :: Handler Curso
    runDB $ replace cid editarCurso
    sendStatusJSON noContent204 (object [])