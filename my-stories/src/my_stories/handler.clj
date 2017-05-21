(ns my-stories.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [compojure.handler :as handler]
            [clojure.java.io :as io]
            [ring.middleware.json :refer [wrap-json-response wrap-json-body]]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]
            [my-stories.stories :as stories]
            [environ.core :refer [env]]))

(def db (env :database-url))
(def only-proj "newpr0j")

(defroutes app-routes
  (GET "/" [] (slurp (io/resource "public/index.html")))
  (route/resources "/")
  (route/not-found "Not Found"))

(defroutes api-routes
  (context "/api/stories" []
           (POST "/" request
                 {:body {:message "ok" :project only-proj}})
           (GET "/:project" request
                {:body {:stories
                        (stories/all-stories-for db {:projectId only-proj})}})))

(def api
  (-> (handler/api api-routes)
      (wrap-json-body {:keywords? true})
      wrap-json-response))

(def app
  (routes api app-routes))
