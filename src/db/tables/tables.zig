const sqlite = @import("sqlite");

const books_table = @import("../tables/books.zig");
const papers_table = @import("../tables/papers.zig");
const podcasts_table = @import("../tables/podcasts.zig");
const songs_table = @import("../tables/songs.zig");
const video_games_table = @import("../tables/video_games.zig");
const movies_table = @import("../tables/movies.zig");
const shows_table = @import("../tables/shows.zig");

pub fn create_all_tables(db: *sqlite.Db) anyerror!void {
    try books_table.create_books_table(db);
    try papers_table.create_papers_table(db);
    try podcasts_table.create_podcasts_table(db);
    try songs_table.create_songs_table(db);
    try video_games_table.create_video_games_table(db);
    try movies_table.create_movies_table(db);
    try shows_table.create_shows_table(db);
}
