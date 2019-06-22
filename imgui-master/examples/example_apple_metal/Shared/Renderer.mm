#import "Renderer.h"
#import <Metal/Metal.h>
#include <iostream>
#include "imgui.h"
#include "imgui_impl_metal.h"
#include "../../../imgui_internal.h"

#if TARGET_OS_OSX
#include "imgui_impl_osx.h"
#endif
#include "fonts.h"

@interface Renderer ()
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;
@end

@implementation Renderer

-(nonnull instancetype)initWithView:(nonnull MTKView *)view;
{
    self = [super init];
    if(self)
    {
        _device = view.device;
        _commandQueue = [_device newCommandQueue];
        
        IMGUI_CHECKVERSION();
        ImGui::CreateContext();
        
        ImGui_ImplMetal_Init(_device);
    }
    
    return self;
}

- (void)drawInMTKView:(MTKView *)view
{
    ImGuiIO &io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;
    
    ImFont* font = io.Fonts->AddFontFromMemoryCompressedTTF(font_data, font_size, 20.0f);
    
#if TARGET_OS_OSX
    CGFloat framebufferScale = view.window.screen.backingScaleFactor ?: NSScreen.mainScreen.backingScaleFactor;
#else
    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
#endif
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 60);
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    static float clear_color[4] = { 0.28f, 0.36f, 0.5f, 1.0f };
    MTLRenderPassDescriptor *renderPassDescriptor = view.currentRenderPassDescriptor;
    if (renderPassDescriptor != nil)
    {
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(clear_color[0], clear_color[1], clear_color[2], clear_color[3]);
        id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        [renderEncoder pushDebugGroup:@"ImGui demo"];
        ImGui_ImplMetal_NewFrame(renderPassDescriptor);
#if TARGET_OS_OSX
        ImGui_ImplOSX_NewFrame(view);
#endif
        ImGui::NewFrame();
        {
            ImGuiStyle* style = &ImGui::GetStyle();
            ImVec4* colors = style->Colors;
            
            
            
            colors[ImGuiCol_Text] =                 ImVec4(0.90f, 0.90f, 0.90f, 1.00f);
            colors[ImGuiCol_TextDisabled] =         ImVec4(0.50f, 0.50f, 0.50f, 1.00f);
            colors[ImGuiCol_WindowBg] =             ImVec4(0.13f, 0.13f, 0.13f, 1.00f);
            colors[ImGuiCol_PopupBg] =              ImVec4(0.13f, 0.14f, 0.15f, 1.00f);
            colors[ImGuiCol_Border] =               ImVec4(0.20f, 0.20f, 0.20f, 1.00f);
            colors[ImGuiCol_BorderShadow] =         ImVec4(0.00f, 0.00f, 0.00f, 0.00f);
            colors[ImGuiCol_ChildWindowBg] =        ImVec4(0.13f, 0.14f, 0.15f, 1.00f);
            colors[ImGuiCol_FrameBg] =              ImVec4(0.200, 0.200, 0.200, 1.000);
            colors[ImGuiCol_FrameBgHovered] =       ImVec4(0.180, 0.180, 0.180, 1.000);
            colors[ImGuiCol_FrameBgActive] =        ImVec4(0.180, 0.180, 0.180, 1.000);
            colors[ImGuiCol_TitleBgActive] =        ImVec4(0.13f, 0.13f, 0.13f, 1.00f);
            colors[ImGuiCol_TitleBg] =              ImVec4(0.13f, 0.13f, 0.13f, 1.00f);
            colors[ImGuiCol_TitleBgCollapsed] =     ImVec4(0.13f, 0.13f, 0.13f, 1.00f);
            colors[ImGuiCol_MenuBarBg] =            ImVec4(0.14f, 0.14f, 0.14f, 1.00f);
            colors[ImGuiCol_ScrollbarBg] =          ImVec4(0.00f, 0.00f, 0.00f, 0.00f);
            colors[ImGuiCol_ScrollbarGrab] =        ImVec4(0.180, 0.478, 0.937, 0.600);
            colors[ImGuiCol_ScrollbarGrabHovered] = ImVec4(0.180, 0.796, 0.937, 0.800);
            colors[ImGuiCol_ScrollbarGrabActive] =  ImVec4(0.180, 0.796, 0.937, 0.800);
            colors[ImGuiCol_CheckMark] =            ImVec4(0.180, 0.478, 0.937, 0.600);
            colors[ImGuiCol_SliderGrab] =           ImVec4(0.180, 0.478, 0.937, 0.600);
            colors[ImGuiCol_SliderGrabActive] =     ImVec4(0.180, 0.796, 0.937, 0.800);
            colors[ImGuiCol_Button] =               ImVec4(0.180, 0.478, 0.937, 0.600);
            colors[ImGuiCol_ButtonHovered] =        ImVec4(0.180, 0.796, 0.937, 0.800);
            colors[ImGuiCol_ButtonActive] =         ImVec4(0.180, 0.796, 0.937, 0.800);
            colors[ImGuiCol_Header] =               ImVec4(167 / 255.f, 24 / 255.f, 71 / 255.f, 1.0f);
            colors[ImGuiCol_HeaderHovered] =        ImVec4(35 / 255.f, 35 / 255.f, 35 / 255.f, 1.0f);
            colors[ImGuiCol_HeaderActive] =         ImVec4(35 / 255.f, 35 / 255.f, 35 / 255.f, 1.0f);
            colors[ImGuiCol_Separator] =            ImVec4(0, 0, 0, 1);
            colors[ImGuiCol_SeparatorHovered] =     ImVec4(0, 0, 0, 1);
            colors[ImGuiCol_SeparatorActive] =      ImVec4(0, 0, 0, 1);
            colors[ImGuiCol_ResizeGrip] =           ImVec4(0.26f, 0.59f, 0.98f, 0.25f);
            colors[ImGuiCol_ResizeGripHovered] =    ImVec4(0.26f, 0.59f, 0.98f, 0.67f);
            colors[ImGuiCol_ResizeGripActive] =     ImVec4(0.26f, 0.59f, 0.98f, 0.95f);
            colors[ImGuiCol_PlotLines] =            ImVec4(0.61f, 0.61f, 0.61f, 1.00f);
            colors[ImGuiCol_PlotLinesHovered] =     ImVec4(1.00f, 0.43f, 0.35f, 1.00f);
            colors[ImGuiCol_PlotHistogram] =        ImVec4(0.90f, 0.70f, 0.00f, 1.00f);
            colors[ImGuiCol_PlotHistogramHovered] = ImVec4(1.00f, 0.60f, 0.00f, 1.00f);
            colors[ImGuiCol_TextSelectedBg] =       ImVec4(0.26f, 0.59f, 0.98f, 0.35f);
            
            auto tab_active = ImVec4(0.180, 0.796, 0.937, 0.800);
            
            style->Alpha                   = 1.0f;
            style->WindowPadding           = ImVec2(8,8);
            style->WindowRounding          = 0.0f;
            style->WindowBorderSize        = 0.0f;
            style->WindowMinSize           = ImVec2(32,32);
            style->WindowTitleAlign        = ImVec2(0.5f,0.5f);
            style->WindowMenuButtonPosition= ImGuiDir_Left;
            style->ChildRounding           = 0.0f;
            style->ChildBorderSize         = 0.0f;
            style->PopupRounding           = 0.0f;
            style->PopupBorderSize         = 0.0f;
            style->FramePadding            = ImVec2(4,3);
            style->FrameRounding           = 0.0f;
            style->FrameBorderSize         = 0.0f;
            style->ItemSpacing             = ImVec2(8,4);
            style->ItemInnerSpacing        = ImVec2(4,4);
            style->TouchExtraPadding       = ImVec2(0,0);
            style->IndentSpacing           = 21.0f;
            style->ColumnsMinSpacing       = 6.0f;
            style->ScrollbarSize           = 14.0f;
            style->ScrollbarRounding       = 0.0f;
            style->GrabMinSize             = 10.0f;
            style->GrabRounding            = 0.0f;
            style->TabRounding             = 0.0f;
            style->TabBorderSize           = 0.0f;
            style->ButtonTextAlign         = ImVec2(0.5f,0.5f);
            style->SelectableTextAlign     = ImVec2(0.0f,0.0f);
            style->DisplayWindowPadding    = ImVec2(19,19);
            style->DisplaySafeAreaPadding  = ImVec2(3,3);
            style->MouseCursorScale        = 1.0f;
            style->AntiAliasedLines        = true;
            style->AntiAliasedFill         = true;
            style->CurveTessellationTol    = 1.25f;
            ImGui::PushFont(font);
            ImGui::SetNextWindowSize(ImVec2(650, 400));
            if (ImGui::Begin("metaro", NULL, ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoScrollbar)) {
                
                static int page{ 0 };
                const char* tabs[] {
                    "tab 1",
                    "tab 2",
                    "tab 3"
                };
                ImGui::Spacing();
                ImGui::PushStyleVar(ImGuiStyleVar_FrameBorderSize, 1.0f);
                ImGui::PushStyleColor(ImGuiCol_FrameBg, ImVec4(0.150, 0.150, 0.150, 1.000));
                ImGui::BeginChildFrame(1, ImVec2(115, ImGui::GetWindowSize().y - 40), ImGuiWindowFlags_NoScrollbar);
                ImGui::PopStyleColor();
                ImGui::PopStyleVar();
                for (int i = 0; i < IM_ARRAYSIZE(tabs); i++)
                {
                    if (page == i) {
                        ImGui::PushStyleColor(ImGuiCol_Button, tab_active);
                        ImGui::PushStyleColor(ImGuiCol_ButtonHovered, tab_active);
                        ImGui::Button(tabs[i], ImVec2(107, 40));
                        ImGui::PopStyleColor(2);
                    } else {
                        if (ImGui::Button(tabs[i], ImVec2(107, 40)))
                            page = i;
                    }
                }
                ImGui::EndChildFrame();
                
                ImGui::SameLine();
                
                ImGui::PushStyleVar(ImGuiStyleVar_FrameBorderSize, 1.0f);
                ImGui::PushStyleColor(ImGuiCol_FrameBg, ImVec4(0.150, 0.150, 0.150, 1.000));
                ImGui::BeginChildFrame(2, ImVec2(ImGui::GetWindowSize().x - 140, ImGui::GetWindowSize().y - 40));
                ImGui::PopStyleColor();
                ImGui::PopStyleVar();
                switch (page) {
                    case 0:
                        break;
                }
                ImGui::EndChildFrame();
                
                ImGui::End();
                ImGui::PopFont();
            }
        }
        ImGui::Render();
        ImDrawData *drawData = ImGui::GetDrawData();
        ImGui_ImplMetal_RenderDrawData(drawData, commandBuffer, renderEncoder);
        
        [renderEncoder popDebugGroup];
        [renderEncoder endEncoding];
        
        [commandBuffer presentDrawable:view.currentDrawable];
    }
    [commandBuffer commit];
}
- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size
{
}
@end
