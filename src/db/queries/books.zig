const std = @import("std");
const sqlite = @import("sqlite");
const models = @import("../models/books.zig");

pub fn fetch_books(db: *sqlite.Db, content_type: []const u8, allocator: std.mem.Allocator) anyerror![]models.BookRow {
    const stmt = try db.prepare(
        \\SELECT id, content_type, title, author, additional_info, created_at
        \\FROM books
        \\WHERE content_type = $content_type{[]const u8}
    );

    const rows = try stmt.all(models.BookRow, allocator, .{}, .{
        .content_type = content_type,
    });

    return rows;
}
