const std = @import("std");
const sqlite = @import("sqlite");

pub fn create_videos_table(db: *sqlite.Db) anyerror!void {
    try db.exec(
        \\CREATE TABLE IF NOT EXISTS podcasts (
        \\    id INTEGER PRIMARY KEY AUTOINCREMENT,
        \\    title TEXT NOT NULL,
        \\    channel TEXT NOT NULL,
        \\    url TEXT NOT NULL
        \\    additional_info TEXT,
        \\    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        \\);
    , .{}, .{});
}
