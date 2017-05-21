(defproject my-stories "0.1.0-SNAPSHOT"
  :description "Share your stories with the team"
  :url "http://github.com/rafasf/my-stories"
  :min-lein-version "2.0.0"
  :dependencies [[org.clojure/clojure "1.9.0-alpha15"]
                 [compojure "1.5.1"]
                 [ring/ring-defaults "0.2.1"]
                 [ring/ring-json "0.4.0"]
                 [http-kit "2.3.0-alpha2"]
                 [environ "1.1.0"]
                 [migratus "0.9.3"]
                 [org.postgresql/postgresql "9.4.1212"]
                 [org.slf4j/slf4j-log4j12 "1.7.9"]
                 [com.layerware/hugsql "0.4.7"]]

  :plugins [[lein-ring "0.9.7"]
            [lein-environ "1.1.0"]
            [migratus-lein "0.4.7"]]

  :migratus {:store :database
             :migration-dir "migrations"
             :db ~(get (System/getenv) "DATABASE_URL")}

  :ring {:handler my-stories.handler/app}
  :profiles
  {:dev {:dependencies [[javax.servlet/servlet-api "2.5"]
                        [ring/ring-mock "0.3.0"]]}})
