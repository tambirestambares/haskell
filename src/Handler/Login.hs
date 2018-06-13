{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Handler.Login where

import Import
import Database.Persist.Postgresql

postLoginAppR :: Handler TypedContent
postLoginAppR = do
    (email, senha) <- requireJsonBody :: Handler (Text, Text)
    escola <- runDB $ selectFirst [ EscolaEmail ==. email
                                  , EscolaSenha ==. senha
                                  ] []
    voluntario <- runDB $ selectFirst [ VoluntarioEmail ==. email
                                  , VoluntarioSenha ==. senha
                                  ] []
    host <- runDB $ selectFirst [ HostEmail ==. email
                                  , HostSenha ==. senha
                                  ] []
    sendStatusJSON ok200 $ object [ "escola" .= escola 
                                  , "voluntario" .= voluntario
                                  , "host" .= host
                                  ]