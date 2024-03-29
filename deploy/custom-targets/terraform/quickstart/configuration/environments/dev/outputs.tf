/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "network" {
    value = module.network.network
    description = "The network resource created"
}

output "network_name" {
    value = module.network.network.name
    description = "The name of the network created"
}

output "network_id" {
    value = module.network.network.id
    description = "The ID of the network created"
}

output "network_description" {
    value = module.network.network.description
    description = "The description of the network created"
}