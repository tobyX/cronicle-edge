
if(!(Test-Path .\node_modules)) {
# install bundler
npm i esbuild -g 
# some optional packages to demo storage engines
npm i level redis@3.1.2 ssh2-sftp-client @aws-sdk/client-s3 @aws-sdk/lib-storage knex pg pg-query-stream mysql2 
}

mkdir -EA SilentlyContinue dist/htdocs/js/external, dist/htdocs/css, dist/htdocs/fonts
Copy-Item -Force -r htdocs dist/

# EXTERNAL JS
Copy-Item -Force  `
  node_modules/jquery/dist/jquery.min.js `
 ,node_modules/moment/min/moment.min.js `
 ,node_modules/moment-timezone/builds/moment-timezone-with-data.min.js `
 ,node_modules/chart.js/dist/Chart.min.js `
 ,node_modules/jstimezonedetect/dist/jstz.min.js `
 ,node_modules/zxcvbn/dist/zxcvbn.js `
 ,node_modules/socket.io/client-dist/socket.io.min.js `
 ,node_modules/ansi_up/ansi_up.js `
 ,node_modules/jquery-ui-dist/jquery-ui.min.js `
 ,node_modules/graphlib/dist/graphlib.min.js `
 ,node_modules/vis-network/dist/vis-network.min.js `
 ,node_modules/xss/dist/xss.min.js `
 ,node_modules/jquery-datetimepicker/build/jquery.datetimepicker.full.min.js `
 ,node_modules/diff/dist/diff.min.js `
dist/htdocs/js/external/

# CSS
Copy-Item -Force htdocs/css/style.css `
  , node_modules/font-awesome/css/font-awesome.min.css `
  , node_modules/@mdi/font/css/materialdesignicons.min.css `
  , node_modules/jquery-ui-dist/jquery-ui.min.css `
  , node_modules/jquery-datetimepicker/build/jquery.datetimepicker.min.css `
  , node_modules/pixl-webapp/css/base.css `
  , node_modules/chart.js/dist/Chart.min.css `
dist/htdocs/css/

# FONTS
Copy-Item -Force `
  node_modules/font-awesome/fonts/* `
 ,node_modules/@mdi/font/fonts/*.woff `
 ,node_modules/pixl-webapp/fonts/*.woff `
dist/htdocs/fonts/

# code mirror css (combo)
Get-Content `
	 node_modules/codemirror/lib/codemirror.css `
	,node_modules/codemirror/theme/darcula.css `
	,node_modules/codemirror/theme/solarized.css `
	,node_modules/codemirror/theme/gruvbox-dark.css `
	,node_modules/codemirror/addon/scroll/simplescrollbars.css `
	,node_modules/codemirror/addon/display/fullscreen.css `
	,node_modules/codemirror/addon/lint/lint.css `
	,node_modules/codemirror/addon/fold/foldgutter.css `
  > dist/htdocs/css/codemirror.css

# codemirror js (combo)
Get-Content `
	   node_modules/codemirror/lib/codemirror.js `
	 , node_modules/codemirror/addon/scroll/simplescrollbars.js `
	 , node_modules/codemirror/addon/edit/matchbrackets.js `
	 , node_modules/codemirror/addon/selection/active-line.js `
	 , node_modules/codemirror/addon/fold/foldgutter.js `
	 , node_modules/codemirror/addon/fold/foldcode.js `
	 , node_modules/codemirror/addon/fold/brace-fold.js `
	 , node_modules/codemirror/addon/fold/indent-fold.js `
	 , node_modules/codemirror/mode/powershell/powershell.js `
	 , node_modules/codemirror/mode/javascript/javascript.js `
	 , node_modules/codemirror/mode/python/python.js `
	 , node_modules/codemirror/mode/perl/perl.js `
	 , node_modules/codemirror/mode/shell/shell.js `
	 , node_modules/codemirror/mode/groovy/groovy.js `
	 , node_modules/codemirror/mode/clike/clike.js `
	 , node_modules/codemirror/mode/properties/properties.js `
	 , node_modules/codemirror/addon/display/fullscreen.js `
	 , node_modules/codemirror/mode/xml/xml.js `
	 , node_modules/codemirror/mode/sql/sql.js `
   , node_modules/js-yaml/dist/js-yaml.js `
	 , node_modules/codemirror/addon/lint/lint.js `
	 , node_modules/codemirror/addon/lint/json-lint.js `
	 , node_modules/codemirror/addon/lint/yaml-lint.js `
	 , node_modules/codemirror/addon/mode/simple.js `
	 , node_modules/codemirror/mode/dockerfile/dockerfile.js `
	 , node_modules/codemirror/mode/toml/toml.js `
	 , node_modules/codemirror/mode/yaml/yaml.js `
	 , node_modules/codemirror/addon/comment/comment.js `
   , node_modules/jsonlint-mod/lib/jsonlint.js `
   | esbuild --minify > dist/htdocs/js/codemirror.min.js

# ----- MAIN ------ #

# CRONICLE FRONT END

Get-Content `
    node_modules/pixl-webapp/js/md5.js `
  , node_modules/pixl-webapp/js/oop.js `
  , node_modules/pixl-webapp/js/xml.js `
  , node_modules/pixl-webapp/js/tools.js `
  , node_modules/pixl-webapp/js/datetime.js `
  , node_modules/pixl-webapp/js/page.js `
  , node_modules/pixl-webapp/js/dialog.js `
  , node_modules/pixl-webapp/js/base.js `
  | esbuild --minify --keep-names > dist/htdocs/js/common.min.js

Get-Content `
    htdocs/js/app.js `
  , htdocs/js/pages/Base.class.js `
  , htdocs/js/pages/Home.class.js `
  , htdocs/js/pages/Login.class.js `
  , htdocs/js/pages/Schedule.class.js `
  , htdocs/js/pages/History.class.js `
  , htdocs/js/pages/JobDetails.class.js `
  , htdocs/js/pages/MyAccount.class.js `
  , htdocs/js/pages/Admin.class.js `
  , htdocs/js/pages/admin/Categories.js `
  , htdocs/js/pages/admin/Servers.js `
  , htdocs/js/pages/admin/Users.js `
  , htdocs/js/pages/admin/Plugins.js `
  , htdocs/js/pages/admin/Activity.js `
  , htdocs/js/pages/admin/APIKeys.js `
  , htdocs/js/pages/admin/ConfigKeys.js `
  , htdocs/js/pages/admin/Secrets.js `
  | esbuild --minify --keep-names > dist/htdocs/js/combo.min.js

Copy-Item -Force htdocs/index-bundle.html dist/htdocs/index.html
  
Copy-Item -Force -r bin dist/
Copy-Item -Force -r sample_conf/ dist/conf
Copy-Item -Force package.json dist/bin/

esbuild --bundle --minify --platform=node --outdir=dist/bin/ `
 --external:../conf/config.json --external:../conf/storage.json --external:../conf/setup.json `
bin/storage-cli.js

esbuild --bundle --minify --platform=node --outdir=dist/bin/  bin/shell-plugin.js
esbuild --bundle --minify --platform=node --outdir=dist/bin/  bin/test-plugin.js
esbuild --bundle --minify --platform=node --outdir=dist/bin/  bin/url-plugin.js
esbuild --bundle --minify --platform=node --outdir=dist/bin/  --loader:.node=file bin/ssh-plugin.js
esbuild --bundle --minify --platform=node --outdir=dist/bin/  bin/workflow.js
esbuild --bundle --minify --platform=node --outdir=dist/bin/  bin/run-detached.js

esbuild --bundle --minify --platform=node --outdir=dist/bin/engines node_modules/pixl-server-storage/engines/Filesystem.js
esbuild --bundle --minify --platform=node --outdir=dist/bin/engines node_modules/pixl-server-storage/engines/Redis.js
esbuild --bundle --minify --platform=node --outdir=dist/bin/engines engines/S3.js
esbuild --bundle --minify --platform=node --outdir=dist/bin/engines --loader:.node=file engines/Sftp.js

esbuild --bundle --minify --platform=node --outdir=dist/bin/engines engines/Level.js
#  still need copy native module manually to make Lmdb work
 $lmdbDir = mkdir -EA SilentlyContinue dist/bin/engines/prebuilds/win32-x64/
 Copy-Item -Force node_modules\classic-level\prebuilds\win32-x64\node.napi.node $lmdbDir


# SQL engine bundle up knex, mysql2 and pg. You can install sqlite3, oracledb, tedious separetly
esbuild --bundle --minify --platform=node --external:oracledb --external:sqlite3 `
 --external:mysql  --external:tedious --external:pg-native --external:better-sqlite3  `
 --outdir=dist/bin/engines engines/SQL.js

# Lmdb, need to install lmdb separetly (npm i lmdb)
esbuild --bundle --minify --platform=node --outdir=dist/bin/engines --external:lmdb engines/Lmdb.js 

# clean up 
Remove-Item -Recurse -Force `
    dist/bin/jars `
  , dist/bin/cms `
  , dist/bin/cronicled.init `
  , dist/bin/importkey.sh `
  , dist/bin/debug.sh `
  , dist/bin/java-plugin.js `
  , dist/bin/install.js `
  , dist/bin/build.js `
  , dist/bin/build-tools.js `

# generate sample secret_key. Please change, or use CRONICLE_secret_key variable to overwrite
-join ((48..57) + (97..122) | Get-Random -Count 32 | % {[char]$_}) > dist/conf/secret_key

# --- CRONICLE.JS
esbuild --bundle --minify --keep-names --platform=node --outfile=dist/bin/cronicle.js lib/main.js


<# 
node .\dist\bin\storage-cli.js setup   # setup
node .\dist\bin\cronicle.js --echo --foreground --manager --color
#>