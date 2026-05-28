" space indent:
set softtabstop=4
set expandtab
set nosmarttab

"remove smarttab
" let b:ale_linters = ['ruff', 'mypy', 'ty']
let b:ale_linters = ['ruff', 'ty']
let b:ale_python_pylint_options = '-d no-name-in-module,wrong-import-order,no-member,unused-argument'


" let b:ale_linters = ['pylsp']
" PyLSP config
" List of options: https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
let g:ale_python_pylsp_config = {
	\	'pylsp': {
	\		'plugins': {
	\			'ruff': {
	\				'enabled': v:true
	\			},
	\			'flake8': {
	\				'enabled': v:false
	\			},
	\			'mypy': {
	\				'enabled': v:true
	\			},
	\			'pycodestyle': {
	\				'enabled': v:false
	\			},
	\			'pylint': {
	\				'enabled': v:false
	\			}
	\		}
	\	}
	\}



let b:ale_fixers = ['ruff']
