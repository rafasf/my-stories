-- :name all-stories-for :?
-- :doc retrieves all stories for given project
SELECT * FROM story
WHERE projectId = :projectId
