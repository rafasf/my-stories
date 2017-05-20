(ns my-stories.handler-test
  (:require [clojure.test :refer :all]
            [ring.mock.request :as mock]
            [my-stories.handler :refer :all]))

(deftest test-app
  (testing "main route"
    (let [response (app (mock/request :get "/"))]
      (is (= (:status response) 200))
      (is (= (:body response) "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n  <meta charset=\"UTF-8\">\n  <title>Stories</title>\n  <link rel=\"stylesheet\" href=\"styles.css\">\n</head>\n<body>\n  <div></div>\n  <script src=\"app.js\"></script>\n  <script>Elm.App.embed(document.querySelector(\"div\"));</script>\n</body>\n</html>\n"))))

  (testing "not-found route"
    (let [response (app (mock/request :get "/invalid"))]
      (is (= (:status response) 404)))))
