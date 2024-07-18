-- 1. One album belongs to one artist. However, one artist may have zero or more albums.
-- To find artists who do not have any albums by using the LEFT JOIN clause, we select 
-- artists and their corresponding albums. If an artist does not have any albums, the value 
-- of the AlbumId column is NULL.
SELECT
   artists.ArtistId, 
   AlbumId
FROM artists
LEFT JOIN albums ON albums.ArtistId = artists.ArtistId
ORDER BY AlbumId;


-- 2. find the artists who don't have album
SELECT
   artists.ArtistId, 
   AlbumId
FROM artists 
LEFT JOIN albums ON albums.ArtistId = artists.ArtistId
WHERE AlbumId IS NULL;