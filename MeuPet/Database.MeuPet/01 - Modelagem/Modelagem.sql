CREATE DATABASE MeuPet;

USE MeuPet
GO

CREATE SCHEMA Administrativo
GO

CREATE SCHEMA Cadastro
GO

CREATE TABLE Administrativo.Empresas(
	EmpresaId INT PRIMARY KEY IDENTITY NOT NULL,
	Token VARCHAR(36) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	CNPJ VARCHAR(18) NOT NULL,
	DataAbertura DATETIME2,
	Email VARCHAR(256) NOT NULL,
	CEP VARCHAR(9) NOT NULL,
	Endereco VARCHAR(100) NOT NULL,
	Numero VARCHAR(5) NOT NULL,
	Complemento VARCHAR(50),
	Bairro VARCHAR(100) NOT NULL,
	Cidade VARCHAR(100) NOT NULL,
	Estado VARCHAR(100) NOT NULL,
	Whatsapp VARCHAR(16) NOT NULL,
	Logo VARCHAR(256),
);

CREATE TABLE Administrativo.Usuarios(
	UsuarioId INT PRIMARY KEY IDENTITY NOT NULL,
	EmpresaId INT FOREIGN KEY(EmpresaId) REFERENCES Administrativo.Empresas(EmpresaId) NOT NULL,
	AspNetUserId VARCHAR(256) NOT NULL,
	Token VARCHAR(36) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Sobrenome VARCHAR(100) NOT NULL,
	CriadoPor INT FOREIGN KEY(CriadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	EditadoPor INT FOREIGN KEY(EditadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	CriadoEm DATETIME2 DEFAULT GETDATE(),
	EditadoEm DATETIME2 DEFAULT GETDATE(),
	Ativo BIT DEFAULT(1)
);

CREATE TABLE Cadastro.Especies(
	EspecieId INT PRIMARY KEY IDENTITY NOT NULL,
	EmpresaId INT FOREIGN KEY(EmpresaId) REFERENCES Administrativo.Empresas(EmpresaId) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	CriadoPor INT FOREIGN KEY(CriadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	EditadoPor INT FOREIGN KEY(EditadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	CriadoEm DATETIME2 DEFAULT GETDATE(),
	EditadoEm DATETIME2 DEFAULT GETDATE(),
	Ativo BIT DEFAULT(1)
);

CREATE TABLE Cadastro.Sexos(
	SexoId INT PRIMARY KEY IDENTITY NOT NULL,
	EmpresaId INT FOREIGN KEY(EmpresaId) REFERENCES Administrativo.Empresas(EmpresaId) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	CriadoPor INT FOREIGN KEY(CriadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	EditadoPor INT FOREIGN KEY(EditadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	CriadoEm DATETIME2 DEFAULT GETDATE(),
	EditadoEm DATETIME2 DEFAULT GETDATE(),
	Ativo BIT DEFAULT(1)
);

CREATE TABLE Cadastro.Pelagens(
	PelagemId INT PRIMARY KEY IDENTITY NOT NULL,
	EmpresaId INT FOREIGN KEY(EmpresaId) REFERENCES Administrativo.Empresas(EmpresaId) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	CriadoPor INT FOREIGN KEY(CriadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	EditadoPor INT FOREIGN KEY(EditadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	CriadoEm DATETIME2 DEFAULT GETDATE(),
	EditadoEm DATETIME2 DEFAULT GETDATE(),
	Ativo BIT DEFAULT(1)
);

CREATE TABLE Cadastro.Estados(
	EstadoId INT PRIMARY KEY IDENTITY NOT NULL,
	EmpresaId INT FOREIGN KEY(EmpresaId) REFERENCES Administrativo.Empresas(EmpresaId) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	CriadoPor INT FOREIGN KEY(CriadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	EditadoPor INT FOREIGN KEY(EditadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	CriadoEm DATETIME2 DEFAULT GETDATE(),
	EditadoEm DATETIME2 DEFAULT GETDATE(),
	Ativo BIT DEFAULT(1)
);

CREATE TABLE Administrativo.Animais(
	AnimalId INT PRIMARY KEY IDENTITY NOT NULL,
	EspecieId INT FOREIGN KEY(EspecieId) REFERENCES Cadastro.Especies(EspecieId) NOT NULL,
	SexoId INT FOREIGN KEY(EspecieId) REFERENCES Cadastro.Sexos(SexoId) NOT NULL,
	DataNascimento DATETIME2,
	Token VARCHAR(36) NOT NULL,
	Nome VARCHAR(100) NOT NULL,
	Idade INT NOT NULL,
	CEP VARCHAR(9) NOT NULL,
	Endereco VARCHAR(100) NOT NULL,
	Numero VARCHAR(5) NOT NULL,
	Complemento VARCHAR(50),
	Bairro VARCHAR(100) NOT NULL,
	Cidade VARCHAR(100) NOT NULL,
	EstadoId INT FOREIGN KEY(EstadoId) REFERENCES Cadastro.Estados(EstadoId) NOT NULL,
	CriadoPor INT FOREIGN KEY(CriadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	EditadoPor INT FOREIGN KEY(EditadoPor) REFERENCES Administrativo.Usuarios(UsuarioId),
	CriadoEm DATETIME2 DEFAULT GETDATE(),
	EditadoEm DATETIME2 DEFAULT GETDATE(),
	Ativo BIT DEFAULT(1)
);