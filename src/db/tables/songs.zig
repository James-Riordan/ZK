const std = @import("std");
const sqlite = @import("sqlite");

pub fn create_songs_table(db: *sqlite.Db) anyerror!void {
    const query =
        \\CREATE TABLE IF NOT EXISTS songs (
        \\    id INTEGER PRIMARY KEY AUTOINCREMENT,
        \\    title TEXT NOT NULL,
        \\    artist TEXT,
        \\    additional_info TEXT,
        \\    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        \\);
    ;
    try db.exec(query, .{}, .{});
}
