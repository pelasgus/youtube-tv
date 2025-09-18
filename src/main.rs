// main.rs
// Author: D.A.Pelasgus

use tao::{
    event::{Event, WindowEvent},
    event_loop::{ControlFlow, EventLoop},
    window::WindowBuilder,
};
use wry::{
    dpi::{LogicalPosition, LogicalSize},
    Rect, WebViewBuilder,
};

fn main() -> wry::Result<()> {
    let event_loop = EventLoop::new();
    let window = WindowBuilder::new().build(&event_loop).unwrap();

    // Fullscreen Mode
    window.set_fullscreen(Some(tao::window::Fullscreen::Borderless(
        window.current_monitor(),
    )));
    // Windowed Mode; Comment Above & Un-comment below to switch
    // let window = WindowBuilder::new()
    //     .with_title("My App") // optional: give your window a name
    //     .with_inner_size(tao::dpi::LogicalSize::new(1280.0, 720.0)) // optional default size
    //     .build(&event_loop)
    //     .unwrap();

    #[cfg(not(any(
        target_os = "windows",
        target_os = "macos",
        target_os = "ios",
        target_os = "android"
    )))]
    let fixed = {
        use gtk::prelude::*;
        use tao::platform::unix::WindowExtUnix;
        let fixed = gtk::Fixed::new();
        let vbox = window.default_vbox().unwrap();
        vbox.pack_start(&fixed, true, true, 0);
        fixed.show_all();
        fixed
    };

    let user_agent_string = "Mozilla/5.0 (SMART-TV; LINUX; Tizen 6.5) AppleWebKit/537.36 (KHTML, like Gecko) 85.0.4183.93/6.5 TV Safari/537.36".to_string();

    let build_webview = |builder: WebViewBuilder<'_>| -> wry::Result<wry::WebView> {
        #[cfg(any(
            target_os = "windows",
            target_os = "macos",
            target_os = "ios",
            target_os = "android"
        ))]
        let webview = builder.build(&window)?;

        #[cfg(not(any(
            target_os = "windows",
            target_os = "macos",
            target_os = "ios",
            target_os = "android"
        )))]
        let webview = {
            use wry::WebViewBuilderExtUnix;
            builder.build_gtk(&fixed)?
        };

        Ok(webview)
    };

    let size = window.inner_size().to_logical::<u32>(window.scale_factor());

    let builder = WebViewBuilder::new()
        .with_bounds(Rect {
            position: LogicalPosition::new(0, 0).into(),
            size: LogicalSize::new(size.width, size.height).into(),
        })
        .with_user_agent(&user_agent_string)
        .with_url("https://youtube.com/tv/");
    let webview = build_webview(builder)?;

    event_loop.run(move |event, _, control_flow| {
        *control_flow = ControlFlow::Wait;

        match event {
            Event::WindowEvent {
                event: WindowEvent::Resized(size),
                ..
            } => {
                let size = size.to_logical::<u32>(window.scale_factor());
                // Update the bounds for WebView1 to be fullscreen
                webview
                    .set_bounds(Rect {
                        position: LogicalPosition::new(0, 0).into(),
                        size: LogicalSize::new(size.width, size.height).into(),
                    })
                    .unwrap();
            }
            Event::WindowEvent {
                event: WindowEvent::CloseRequested,
                ..
            } => *control_flow = ControlFlow::Exit,
            _ => {}
        }
    });
}
