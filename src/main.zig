const std = @import("std");
const db = @import("db/init.zig");
const queries = @import("db/queries.zig");
const tables = @import("db/tables/tables.zig");

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer if (gpa.deinit() == .leak) {
        std.debug.panic("leaks detected", .{});
    };

    const gpa_allocator = gpa.allocator();

    // Use ArenaAllocator to manage memory for database-related allocations to avoid mem. leaks
    var arena = std.heap.ArenaAllocator.init(gpa_allocator);
    defer arena.deinit();
    const arena_allocator = arena.allocator();

    var db_instance = try db.init(arena_allocator);
    defer db_instance.deinit();

    std.debug.print("Database initialized successfully.\n", .{});

    // Create tables if they don't exist
    try tables.create_all_tables(&db_instance);

    std.debug.print("All tables created successfully.\n", .{});

    // Insert a new book entry
    try queries.insert_book(&db_instance, "book", "Example_Book", "Jane Doe", "{}");

    std.debug.print("Book Added...\n", .{});

    // Query and print books
    const books = try queries.fetch_books(&db_instance, "book", arena_allocator);
    for (books) |book| {
        std.debug.print("ID: {d}, Content Type: {s}, Title: {s}, Author: {s}, Additional Info: {s}, Created At: {s}\n", .{ book.id, book.content_type, book.title, book.author, book.additional_info, book.created_at });
    }
}
