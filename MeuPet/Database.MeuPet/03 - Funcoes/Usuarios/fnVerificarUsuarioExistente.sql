CREATE FUNCTION [Administrativo].[fnVerificarUsuarioExistente](
	@Usuario VARCHAR(256)
)

RETURNS INT

AS BEGIN

DECLARE @EhUsuarioExistente INT;

SET @EhUsuarioExistente = (
	ISNULL((SELECT usuarios.UsuarioId
	FROM Administrativo.Usuarios usuarios
	JOIN dbo.AspNetUsers users ON users.Id = usuarios.AspNetuserId
	WHERE usuarios.Ativo = 1
	AND usuarios.AspNetuserId <> ''
	AND usuarios.AspNetuserId IS NOT NULL
	AND users.Id = usuarios.AspNetuserId
	AND users.UserName = @Usuario), 0)
)

RETURN @EhUsuarioExistente
END;