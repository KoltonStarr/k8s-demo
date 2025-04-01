use std::fs;
use std::io::prelude::*;
use std::net::{TcpListener, TcpStream};

const IMAGE_PATH: &str = "bubblegutbenjamin.png"; // Change this to your actual image file

fn main() {
    let listener = TcpListener::bind("0.0.0.0:8080").expect("Failed to bind address");
    println!("Server running at http://0.0.0.0:8080");

    for stream in listener.incoming() {
        if let Ok(stream) = stream {
            handle_connection(stream);
        }
    }
}

fn handle_connection(mut stream: TcpStream) {
    let mut buffer = [0; 1024]; // Read request into buffer
    if stream.read(&mut buffer).is_err() {
        return;
    }

    // Read image file
    let image_data = match fs::read(IMAGE_PATH) {
        Ok(data) => data,
        Err(_) => {
            let _ = stream.write_all(b"HTTP/1.1 404 NOT FOUND\r\n\r\n");
            return;
        }
    };

    let header = format!(
        "HTTP/1.1 200 OK\r\n\
        Content-Type: image/png\r\n\
        Content-Length: {}\r\n\
        Connection: close\r\n\r\n",
        image_data.len()
    );

    let _ = stream.write_all(header.as_bytes());
    let _ = stream.write_all(&image_data);
}
