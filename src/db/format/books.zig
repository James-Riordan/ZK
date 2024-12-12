const std = @import("std");

const BookRow = @import("../models/books.zig").BookRow;

pub fn format_books(rows: []BookRow) anyerror![]const u8 {
    // Allocate space for the output (assuming you want to print to an array)
    const output = try std.heap.page_allocator.alloc([]const u8, rows.len);

    // Manually track the index for output storage
    var i: usize = 0;
    for (rows) |row| {
        // Store the formatted string into the output array
        output[i] = try std.fmt.allocPrint(std.heap.page_allocator, "ID: {d}, Content Type: {s}, Title: {s}, Author: {s}, Additional Info: {s}, Created At: {s}\n", .{
            row.id,
            row.content_type,
            row.title,
            row.author,
            row.additional_info,
            row.created_at,
        });
        i += 1;
    }

    return output;
}
