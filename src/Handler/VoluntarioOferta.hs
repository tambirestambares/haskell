{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.VoluntarioOferta where

import Import
import Database.Persist.Postgresql
import Data.Map.Strict (elems)

getVoluntarioOfertaR :: Handler Value
getVoluntarioOfertaR = do
    todasOfertasV <- runDB $ selectList [] [Asc VoluntarioOfertaInicio]
    sendStatusJSON ok200 (object ["resp" .= todasOfertasV])

postVoluntarioOfertaR :: Handler Value
postVoluntarioOfertaR = do
    ofertav <- requireJsonBody :: Handler VoluntarioOferta
    ovid <- runDB $ insert ofertav
    sendStatusJSON created201 (object ["resp" .= fromSqlKey ovid])


getVoluntarioOfertaIdR :: VoluntarioOfertaId -> Handler Value
getVoluntarioOfertaIdR ovid = do 
    ofertav <- runDB $ get404 ovid
    sendStatusJSON ok200 (object ["resp" .= ofertav])

getVolOfertaR :: VoluntarioId -> Handler Value
getVolOfertaR vid = do
    result <- runDB $ do
        voluntarioOfertas <- selectList [VoluntarioOfertaVoluntarioId ==. vid] []
        ofertas <- fmap elems . getMany $ map (voluntarioOfertaOfertaId . entityVal) voluntarioOfertas
        hosts   <- fmap elems . getMany $ map ofertaHostId ofertas
        return $ zip3 voluntarioOfertas ofertas hosts
    sendStatusJSON ok200 $ object ["result" .= result]

getHostOfertaR :: HostId -> Handler Value
getHostOfertaR hid = do
    result <- runDB $ do
        ofertas           <- selectList [OfertaHostId ==. hid] []                                                  -- [Oferta]
        voluntarioOfertas <- mapM ((\oid -> selectList [VoluntarioOfertaOfertaId ==. oid] []) . entityKey) ofertas -- [[VoluntarioOferta]]
        voluntarios       <- mapM (mapM (get .voluntarioOfertaVoluntarioId . entityVal)) voluntarioOfertas         -- [[Voluntario]]
        return . concat $ zipWith3 (\a bs cs -> zipWith ((,,) a) bs cs) ofertas voluntarioOfertas voluntarios      -- [(Oferta, VoluntarioOferta, Voluntario)]
    sendStatusJSON ok200 $ object ["result" .= result]