CREATE FUNCTION [Administrativo].[fnRetornarUsuarioId](@Usuario VARCHAR(256))

RETURNS INT

AS BEGIN

DECLARE @RetornarUsuarioId INT;

SET @RetornarUsuarioId = (
	ISNULL((
		SELECT usuarios.UsuarioId
		FROM Administrativo.Usuarios usuarios
		JOIN dbo.AspNetusers aspNetUser ON aspNetUser.Id = usuarios.AspNetUserId
		WHERE usuarios.Ativo = 1
		AND usuarios.AspNetuserId <> ''
		AND aspNetUser.Id = usuarios.AspNetuserId
		AND aspNetUser.UserName = @Usuario
		),0)
)

RETURN @RetornarUsuarioId

END;