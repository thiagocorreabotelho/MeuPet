USE [MeuPet]
GO
/****** Object:  StoredProcedure [Administrativo].[spValidarTokenUsuario]    Script Date: 21/02/2023 08:32:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Administrativo].[spValidarTokenUsuario] (@UsuarioToken VARCHAR(36), @Usuario VARCHAR(256))
AS
BEGIN
    -- Declare as variáveis necessárias
    DECLARE @ValidarUsuarioExistente INT;
    DECLARE @RetornarUsuarioId INT;
	DECLARE @ValidarTokenRequisitado INT;

    -- Verifica se o usuário foi informado
    IF (@Usuario IS NULL)
        THROW 51000, 'Por favor informar o usuário.', 1;

    -- Verifica se o usuário existe
    SET @ValidarUsuarioExistente = Administrativo.fnVerificarUsuarioExistente(@Usuario);
    IF (@ValidarUsuarioExistente = 0)
        THROW 51000, 'Usuário inválido, tente novamente por favor!', 1;

    -- Verifica se o usuário existe
    SET @RetornarUsuarioId = Administrativo.fnRetornarUsuarioId(@Usuario);
    IF (@RetornarUsuarioId = 0)
        THROW 51000, 'Não foi possível encontrar o usuário, tente novamente por favor!', 1;

	SET @ValidarTokenRequisitado = ISNULL((SELECT 1 FROM dbo.AspNetUserClaims claims WHERE claims.ClaimValue = @UsuarioToken AND claims.ClaimType = 'UsuarioToken'),0)

IF(@ValidarTokenRequisitado = 1)
	BEGIN 
		-- Seleciona as claims do usuário
		SELECT 
			'True' AS EhValido,
			claims.Id,
			claims.ClaimValue as UsuarioToken
		FROM dbo.AspNetUserClaims claims
			 JOIN dbo.AspNetUsers aspNetUser ON aspNetUser.Id = claims.UserId
			 JOIN Administrativo.Usuarios usuarios ON usuarios.Token = @UsuarioToken
		 WHERE claims.ClaimValue = @UsuarioToken
			  AND claims.ClaimType = 'UsuarioToken'
			  AND aspNetUser.Email = @Usuario;

	END
	ELSE
		BEGIN
			SELECT TOP 1 'FALSE' FROM dbo.AspNetUserClaims claims
		END
END;