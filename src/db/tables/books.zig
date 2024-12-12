const std = @import("std");
const sqlite = @import("sqlite");

pub fn create_books_table(db: *sqlite.Db) anyerror!void {
    try db.exec(
        \\CREATE TABLE IF NOT EXISTS books (
        \\    id INTEGER PRIMARY KEY AUTOINCREMENT,
        \\    content_type TEXT NOT NULL,
        \\    title TEXT NOT NULL,
        \\    author TEXT,
        \\    additional_info TEXT,
        \\    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        \\);
    , .{}, .{});
}
