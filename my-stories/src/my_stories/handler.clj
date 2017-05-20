(ns my-stories.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [compojure.handler :as handler]
            [clojure.java.io :as io]
            [ring.middleware.json :refer [wrap-json-response wrap-json-body]]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]))

(defroutes app-routes
  (GET "/" [] (slurp (io/resource "public/index.html")))
  (route/resources "/")
  (route/not-found "Not Found"))

(defroutes api-routes
  (context "/api/stories" []
           (GET "/:project" request
                {:body (slurp (io/resource "public/my-stories-a7fde-export.json"))})
           (POST "/" request
                 {:body {:message "ok" :project "NewPr0j"}})))

(def api
  (-> (handler/api api-routes)
      (wrap-json-body {:keywords? true})
      wrap-json-response))

(def app
  (routes api app-routes))
