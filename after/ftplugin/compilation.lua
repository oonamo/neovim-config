local matchadd = vim.fn.matchadd
matchadd("CompileModeInfo", "^Compilation \\zsfinished\\ze.*")
matchadd(
	"CompileModeError",
	"^Compilation \\zs\\(exited abnormally\\|interrupted\\|killed\\|terminated\\|segmentation fault\\)\\ze"
)
matchadd("CompileModeError", "^Compilation .* with code \\zs[0-9]\\+\\ze")
matchadd("CompileModeOutputFile", " --\\?o\\(utfile\\|utput\\)\\?[= ]\\zs\\(\\S\\+\\)\\ze")
matchadd(
	"CompileModeCheckTarget",
	"^[Cc]hecking \\([Ff]or \\|[Ii]f \\|[Ww]hether \\(to\\)\\?\\)\\?\\zs\\(.\\+\\)\\ze\\.\\.\\."
)
matchadd(
	"CompileModeCheckResult",
	"^[Cc]hecking \\([Ff]or \\|[Ii]f \\|[Ww]hether \\(to\\)\\?\\)\\?\\(.\\+\\)\\.\\.\\. *\\((cached) *\\)\\?\\zs.*\\ze"
)
matchadd(
	"CompileModeInfo",
	"^[Cc]hecking \\([Ff]or \\|[Ii]f \\|[Ww]hether \\(to\\)\\?\\)\\?\\(.\\+\\)\\.\\.\\. *\\((cached) *\\)\\?\\zsyes\\( .\\+\\)\\?\\ze$"
)
matchadd(
	"CompileModeError",
	"^[Cc]hecking \\([Ff]or \\|[Ii]f \\|[Ww]hether \\(to\\)\\?\\)\\?\\(.\\+\\)\\.\\.\\. *\\((cached) *\\)\\?\\zsno\\ze$"
)
matchadd("CompileModeDirectoryMessage", "\\(Entering\\|Leaving\\) directory [`']\\zs.\\+\\ze'$")
