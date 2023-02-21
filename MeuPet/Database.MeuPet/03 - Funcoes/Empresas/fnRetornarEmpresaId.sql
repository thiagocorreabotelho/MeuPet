CREATE FUNCTION [Administrativo].[fnRetornarEmpresaId](@Usuario VARCHAR(256))

RETURNS INT

AS BEGIN

DECLARE @RetornarEmpresaId INT;

SET @RetornarEmpresaId = (
	ISNULL(
		(
			SELECT usuarios.EmpresaId
			FROM Administrativo.Usuarios usuarios
			JOIN dbo.AspNetusers aspNetUsers ON aspNetUsers.Id = usuarios.AspNetUserId
			WHERE usuarios.Ativo = 1
			AND usuarios.AspNetUserId <> ''
			AND aspNetUsers.id = usuarios.AspNetUserId
			AND aspNetUsers.UserName = @Usuario
		)
		,0
	)
)

RETURN @RetornarEmpresaId

END;