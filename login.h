// check if online (gotta actually make it do that)
            bool cstatus{ true };
            bool unload{ false };
            auto green = ImVec4(0.0f, 1.0f, 0.0f, 1.0f);
            
            if (cstatus) {
                // login vars
                static char buffusr[65];
                static char buffpwd[65];
                
                // pre hashed for testing (to do: check for hashes from sql database)
                char cusr[] = "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918";
                char cpwd[] = "8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918";
                
                
                
                // login window
                static bool login{ true };
                if(login) {
                    // create window
                    ImGui::SetNextWindowSize(ImVec2(266, 100));
                    ImGui::Begin("login", &login, ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoResize);
                    // page manager
                    static int page{ 0 };
                    switch (page) {
                        case 0:
                            
                            // text inputs
                            ImGui::Text("username: ");
                            ImGui::SameLine();
                            ImGui::InputText("###usr", buffusr, IM_ARRAYSIZE(buffusr));
                            ImGui::Text("password: ");
                            ImGui::SameLine();
                            ImGui::InputText("###pwd", buffpwd, IM_ARRAYSIZE(buffpwd), ImGuiInputTextFlags_Password);
                            
                            // status thingo
                            if (cstatus)
                                ImGui::TextColored(green, "online");
                            else
                                exit(0);
                            
                            
                            // login button (also encrypts strings)
                            ImGui::SameLine(ImGui::GetWindowWidth() - 51);
                            if(ImGui::Button("login")) {
                                std::string sha256usr = buffusr;
                                std::vector<unsigned char> hashusr(picosha2::k_digest_size);
                                picosha2::hash256(sha256usr.begin(), sha256usr.end(), hashusr.begin(), hashusr.end());
                                std::string ousr = picosha2::bytes_to_hex_string(hashusr.begin(), hashusr.end());
                                const char* usr = ousr.c_str();
                                
                                std::string sha256pwd = buffusr;
                                std::vector<unsigned char> hashpwd(picosha2::k_digest_size);
                                picosha2::hash256(sha256pwd.begin(), sha256pwd.end(), hashpwd.begin(), hashpwd.end());
                                std::string opwd = picosha2::bytes_to_hex_string(hashpwd.begin(), hashpwd.end());
                                const char* pwd = opwd.c_str();
                                
                                if (strcmp(usr, cusr) == 0 && strcmp(pwd, cpwd) == 0) {
                                    page = 1;
                                }
                            }
                            break;
                        case 1:
                            static float progress = 0.0f, progress_dir = 1.0f;
                            progress += progress_dir * 0.4f * ImGui::GetIO().DeltaTime;
                            if (page == 1)
                            {
                                ImGui::NewLine();
                                ImGui::ProgressBar(progress, ImVec2(ImGui::GetWindowWidth() - 15, 0.0f));
                                if (progress >= +1.1f) {
                                    login = false;
                                }
                            }
                            break;
                            
                    }
                    ImGui::End();
                }
                
                if (!login) {
                    static int page{ 0 };
                    static int aimbot_page{ 0 };
                    static int visuals_page{ 0 };
                    char window[] = "metaro";
                    ImGui::SetNextWindowSize(ImVec2(800, 420));
                    ImGui::Begin(window, NULL, ImGuiWindowFlags_NoCollapse | ImGuiWindowFlags_NoResize);
                    ImGui::Columns(2, NULL, false);
                    ImGui::SetColumnOffset(1, 110);
                    ImGui::BeginChildFrame(1, ImVec2(100, 384));
                    if(ImGui::Button("aimbot", ImVec2(92, 91)))
                        page = 0;
                    
                    if(ImGui::Button("visuals", ImVec2(92, 91)))
                        page = 1;
                    
                    if(ImGui::Button("misc", ImVec2(92, 91)))
                        page = 2;
                    
                    if(ImGui::Button("config", ImVec2(92, 91)))
                        page = 3;
                    
                    ImGui::EndChildFrame();
                    ImGui::NextColumn();
                    switch (page) {
                        case 0:
                            ImGui::BeginChildFrame(2, ImVec2(670, 384));
                            ImGui::BeginChildFrame(3, ImVec2(670, 384));
                            ImGui::PushStyleColor(ImGuiCol_FrameBg, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            ImGui::PushStyleColor(ImGuiCol_FrameBgHovered, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            ImGui::PushStyleColor(ImGuiCol_FrameBgActive, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            if(ImGui::Button("legit", ImVec2(327, 0)))
                                aimbot_page = 0;
                            
                            ImGui::SameLine();
                            if(ImGui::Button("rage", ImVec2(327, 0)))
                                aimbot_page = 1;
                            
                            switch (aimbot_page) {
                                case 0:
                                    break;
                                case 1:
                                    break;
                            }
                            
                            ImGui::PopStyleColor();
                            ImGui::PopStyleColor();
                            ImGui::PopStyleColor();
                            ImGui::EndChildFrame();
                            break;
                        case 1:
                            ImGui::BeginChildFrame(3, ImVec2(670, 384));
                            ImGui::PushStyleColor(ImGuiCol_FrameBg, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            ImGui::PushStyleColor(ImGuiCol_FrameBgHovered, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            ImGui::PushStyleColor(ImGuiCol_FrameBgActive, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));

                            if(ImGui::Button("general", ImVec2(215.3, 0)))
                                visuals_page = 0;
                            ImGui::SameLine();
                            if(ImGui::Button("esp", ImVec2(215.3, 0)))
                                visuals_page = 1;
                            ImGui::SameLine();
                            if(ImGui::Button("chams", ImVec2(215.3, 0)))
                                visuals_page = 2;
                            
                            switch (visuals_page) {
                                case 0:
                                    break;
                                case 1:
                                    break;
                                case 2:
                                    break;
                            }
                            
                            ImGui::PopStyleColor();
                            ImGui::PopStyleColor();
                            ImGui::PopStyleColor();
                            ImGui::EndChildFrame();
                            break;
                        case 2:
                            ImGui::BeginChildFrame(4, ImVec2(670, 384));
                            ImGui::Columns(3, NULL, false);
                            ImGui::PushStyleColor(ImGuiCol_FrameBg, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            ImGui::PushStyleColor(ImGuiCol_FrameBgHovered, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            ImGui::PushStyleColor(ImGuiCol_FrameBgActive, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            
                            ImGui::PopStyleColor();
                            ImGui::PopStyleColor();
                            ImGui::PopStyleColor();
                            ImGui::EndChildFrame();
                            break;
                        case 3:
                            ImGui::BeginChildFrame(5, ImVec2(670, 384));
                            ImGui::PushStyleColor(ImGuiCol_FrameBg, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            ImGui::PushStyleColor(ImGuiCol_FrameBgHovered, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            ImGui::PushStyleColor(ImGuiCol_FrameBgActive, ImVec4(0.30f, 0.30f, 0.30f, 1.00f));
                            ImGui::Columns(2, nullptr, false);
                            ImGui::SetColumnOffset(1, 170.0f);
                            
                            ImGui::PushItemWidth(160.0f);
                            
                            constexpr auto& configItems = config.getConfigs();
                            static int currentConfig = -1;
                            
                            if (static_cast<size_t>(currentConfig) >= configItems.size())
                                currentConfig = -1;
                            
                            static char buffer[16];
                            
                            if (ImGui::ListBox("", &currentConfig, [](void* data, int idx, const char** out_text) {
                                auto& vector = *static_cast<std::vector<std::string>*>(data);
                                *out_text = vector[idx].c_str();
                                return true;
                            }, &configItems, configItems.size(), 5) && currentConfig != -1)
                                strcpy(buffer, configItems[currentConfig].c_str());
                            
                            ImGui::PushID(0);
                            if (ImGui::InputText("", buffer, IM_ARRAYSIZE(buffer), ImGuiInputTextFlags_EnterReturnsTrue)) {
                                if (currentConfig != -1)
                                    config.rename(currentConfig, buffer);
                            }
                            ImGui::PopID();
                            ImGui::NextColumn();
                            
                            ImGui::PushItemWidth(100.0f);
                            
                            if (ImGui::Button("Create config", { 100.0f, 25.0f }))
                                config.add(buffer);
                            
                            if (ImGui::Button("Reset config", { 100.0f, 25.0f }))
                                config.reset();
                            
                            if (currentConfig != -1) {
                                if (ImGui::Button("Load selected", { 100.0f, 25.0f }))
                                    config.load(currentConfig);
                                if (ImGui::Button("Save selected", { 100.0f, 25.0f }))
                                    config.save(currentConfig);
                                if (ImGui::Button("Delete selected", { 100.0f, 25.0f }))
                                    config.remove(currentConfig);
                            }

                            ImGui::PopStyleColor();
                            ImGui::PopStyleColor();
                            ImGui::PopStyleColor();
                            ImGui::EndChildFrame();
                            break;
                    }
                    ImGui::End();
                }
                
            }
            else
                unload = true;
            if (unload)
                exit(0);
        }
