# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM ruby:2.7

WORKDIR /app
ADD Gemfile* ./
RUN bundle install

ADD . ./

# Puma serves on 9292 by default. With this we bend it back to Carlessian deafult.
CMD ["bundle","exec","puma", "-p", "8080"]

# Note from Alex: this doesn't guarantee anything. It's just a documentation thingy. Might be worth even REMOVING it.
# https://kubernetes.io/docs/concepts/services-networking/service/#proxy-mode-ipvs
# https://docs.docker.com/engine/reference/builder/#expose
EXPOSE 8080
