CREATE PROCEDURE Administrativo.spCriarClaimsUsuario(@AspNetUserId VARCHAR(36), @ClaimType VARCHAR(MAX), @ClaimValue VARCHAR(MAX),@Usuario varchar(256))

AS BEGIN

DECLARE @ValidarUsuarioExistente INT;
DECLARE @NovoId INT;

SET @ValidarUsuarioExistente = Administrativo.fnVerificarUsuarioExistente(@Usuario);
	IF(@ValidarUsuarioExistente = 0)
		THROW 51000, 'Usuário inválido, tente novamente por favor!', 1;


INSERT dbo.AspNetUserClaims(UserId, ClaimType, ClaimValue)
VALUES (@AspNetUserId, @ClaimType, @ClaimValue)
	
SET @NovoId = SCOPE_IDENTITY()

SELECT @NovoId as Id;
END;
	
