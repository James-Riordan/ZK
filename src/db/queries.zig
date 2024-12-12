// Abstracted Queries via a unified interface across all media types

const std = @import("std");
const sqlite = @import("sqlite");

pub fn insert_book(db: *sqlite.Db, content_type: []const u8, title: []const u8, author: []const u8, additional_info: []const u8) anyerror!void {
    const insert_query =
        \\INSERT INTO books (content_type, title, author, additional_info)
        \\VALUES ($content_type{[]const u8}, $title{[]const u8}, $author{[]const u8}, $additional_info{[]const u8})
    ;
    try db.exec(insert_query, .{}, .{
        .content_type = content_type,
        .title = title,
        .author = author,
        .additional_info = additional_info,
    });
}

const BookRow = struct {
    id: i32,
    content_type: []const u8,
    title: []const u8,
    author: []const u8,
    additional_info: []const u8,
    created_at: []const u8,
};

pub fn fetch_books(db: *sqlite.Db, content_type: []const u8, allocator: std.mem.Allocator) anyerror![]BookRow {
    // Declare stmt as mutable
    var stmt = try db.prepare(
        \\SELECT id, content_type, title, author, additional_info, created_at
        \\FROM books
        \\WHERE content_type = $content_type{[]const u8}
    );

    // Fetch all rows using `all` method, passing the allocator
    const rows = try stmt.all(BookRow, allocator, .{}, .{
        .content_type = content_type,
    });

    return rows;
}
