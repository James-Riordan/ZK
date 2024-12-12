const std = @import("std");
const sqlite = @import("sqlite");

pub fn create_movies_table(db: *sqlite.Db) anyerror!void {
    try db.exec(
        \\CREATE TABLE IF NOT EXISTS movies (
        \\    id INTEGER PRIMARY KEY AUTOINCREMENT,
        \\    title TEXT NOT NULL,
        \\    director TEXT,
        \\    additional_info TEXT,
        \\    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        \\);
    , .{}, .{});
}
