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
