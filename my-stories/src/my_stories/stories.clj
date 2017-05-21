(ns my-stories.stories
  (:require [environ.core :refer [env]]
            [hugsql.core :as hugsql]))

(hugsql/def-db-fns "story/queries.sql")
