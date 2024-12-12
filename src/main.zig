const std = @import("std");
const sqlite = @import("sqlite");

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer if (gpa.deinit() == .leak) {
        std.debug.panic("leaks detected", .{});
    };

    const allocator = gpa.allocator();

    // Initialize the ArenaAllocator (NECESSARY FOR SQLITE to avoid memory leaks)
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    // Initialize the SQLite database in file mode
    var db = try sqlite.Db.init(.{
        .mode = sqlite.Db.Mode{ .File = "./zk.db" },
        .open_flags = .{
            .write = true,
            .create = true,
        },
        .threading_mode = .MultiThread,
    });
    defer db.deinit();

    std.debug.print("Database initialized successfully.\n", .{});

    // Step 1: Create the `content` table if it doesn't exist
    try db.exec(
        \\CREATE TABLE IF NOT EXISTS content (
        \\    id INTEGER PRIMARY KEY AUTOINCREMENT,
        \\    content_type TEXT NOT NULL,
        \\    title TEXT NOT NULL,
        \\    author TEXT,
        \\    additional_info TEXT,
        \\    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        \\);
    , .{}, .{});
    std.debug.print("Table created successfully.\n", .{});

    // Step 2: Insert a new book entry using named parameters
    const insert_query =
        \\INSERT INTO content (content_type, title, author, additional_info)
        \\VALUES ($content_type{[]const u8}, $title{[]const u8}, $author{[]const u8}, $additional_info{[]const u8})
    ;
    try db.exec(insert_query, .{}, .{
        .content_type = @as([]const u8, "book"),
        .title = @as([]const u8, "The Art of Zig Programming"),
        .author = @as([]const u8, "Jane Doe"),
        .additional_info = @as([]const u8, "{}"),
    });
    std.debug.print("Book entry added successfully.\n", .{});

    // Step 3: Query and print all books
    const select_query =
        \\SELECT id, content_type, title, author, additional_info, created_at
        \\FROM content
        \\WHERE content_type = $content_type{[]const u8}
    ;
    var stmt = try db.prepare(select_query);
    defer stmt.deinit();

    // Define the struct that matches the query result row format
    const Row = struct {
        id: i32,
        content_type: []const u8,
        title: []const u8,
        author: []const u8,
        additional_info: []const u8,
        created_at: []const u8,
    };

    // Fetch all rows using `all` method
    const rows = try stmt.all(Row, arena.allocator(), .{}, .{
        .content_type = @as([]const u8, "book"),
    });

    defer arena.allocator().free(rows); // Free memory after usage

    // Iterate over the rows and print the result
    for (rows) |row| {
        std.debug.print("ID: {d}, Content Type: {s}, Title: {s}, Author: {s}, Additional Info: {s}, Created At: {s}\n", .{
            row.id,
            row.content_type,
            row.title,
            row.author,
            row.additional_info,
            row.created_at,
        });
    }
}
