(defproject my-stories-be "0.1.0-SNAPSHOT"
  :description "Share your stories with the team"
  :url "http://github.com/rafasf/my-stories"
  :min-lein-version "2.0.0"
  :dependencies [[org.clojure/clojure "1.9.0-alpha15"]
                 [compojure "1.5.1"]
                 [ring/ring-defaults "0.2.1"]
                 [ring/ring-json "0.4.0"]
                 [http-kit "2.3.0-alpha2"]]
  :plugins [[lein-ring "0.9.7"]]
  :ring {:handler my-stories-be.handler/app}
  :profiles
  {:dev {:dependencies [[javax.servlet/servlet-api "2.5"]
                        [ring/ring-mock "0.3.0"]]}})
