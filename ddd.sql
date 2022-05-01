USE [controle-estoque]
GO
/****** Object:  User [admin]    Script Date: 12/05/2021 21:01:09 ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
/****** Object:  Table [dbo].[cidade]    Script Date: 12/05/2021 21:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cidade](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](30) NOT NULL,
	[ativo] [bit] NOT NULL,
	[id_estado] [int] NOT NULL,
	[id_pais] [int] NOT NULL,
 CONSTRAINT [PK_cidade] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[estado]    Script Date: 12/05/2021 21:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estado](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](30) NOT NULL,
	[uf] [varchar](2) NOT NULL,
	[ativo] [bit] NOT NULL,
	[id_pais] [int] NOT NULL,
 CONSTRAINT [PK_estado] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fornecedor]    Script Date: 12/05/2021 21:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fornecedor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](60) NOT NULL,
	[razao_social] [varchar](100) NULL,
	[num_documento] [varchar](20) NULL,
	[tipo] [int] NOT NULL,
	[telefone] [varchar](20) NOT NULL,
	[contato] [varchar](60) NOT NULL,
	[logradouro] [varchar](100) NOT NULL,
	[numero] [varchar](20) NOT NULL,
	[complemento] [varchar](100) NULL,
	[cep] [varchar](10) NULL,
	[id_pais] [int] NOT NULL,
	[id_estado] [int] NOT NULL,
	[id_cidade] [int] NOT NULL,
	[ativo] [bit] NOT NULL,
 CONSTRAINT [PK_fornecedor] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[grupo_produto]    Script Date: 12/05/2021 21:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[grupo_produto](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [nvarchar](50) NULL,
	[ativo] [bit] NULL,
 CONSTRAINT [PK_grupo_produto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[local_armazenamento]    Script Date: 12/05/2021 21:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[local_armazenamento](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [nvarchar](50) NULL,
	[ativo] [bit] NULL,
 CONSTRAINT [PK_local_armazenamento] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[marca_produto]    Script Date: 12/05/2021 21:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[marca_produto](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [nvarchar](50) NULL,
	[ativo] [bit] NULL,
 CONSTRAINT [PK_marca_produto] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pais]    Script Date: 12/05/2021 21:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pais](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](30) NOT NULL,
	[codigo] [varchar](3) NOT NULL,
	[ativo] [bit] NOT NULL,
 CONSTRAINT [PK_pais] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[perfil]    Script Date: 12/05/2021 21:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[perfil](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](20) NOT NULL,
	[ativo] [bit] NOT NULL,
 CONSTRAINT [PK_perfil] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[perfil_usuario]    Script Date: 12/05/2021 21:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[perfil_usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_perfil] [int] NOT NULL,
	[id_usuario] [int] NOT NULL,
 CONSTRAINT [PK_perfil_usuario] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[unidade_medida]    Script Date: 12/05/2021 21:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[unidade_medida](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nome] [varchar](30) NOT NULL,
	[sigla] [varchar](3) NOT NULL,
	[ativo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario]    Script Date: 12/05/2021 21:01:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[login] [nvarchar](50) NOT NULL,
	[senha] [nvarchar](32) NOT NULL,
	[nome] [nvarchar](100) NOT NULL,
	[id_perfil] [int] NOT NULL,
	[email] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_usuario] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[cidade] ON 

INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (1, N'Fortaleza', 1, 31, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (2, N'Caucaia', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (3, N'Juazeiro do Norte', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (4, N'Maracanaú', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (5, N'Sobral', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (6, N'Crato', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (7, N'Itapipoca', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (8, N'Maranguape', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (9, N'Iguatu', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (10, N'Quixadá', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (11, N'Pacatuba', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (12, N'Quixeramobim', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (13, N'Aquiraz', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (14, N'Russas', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (15, N'Canindé', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (16, N'Tianguá', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (17, N'Crateús', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (18, N'Aracati', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (19, N'Pacajus', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (20, N'Cascavel', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (21, N'Icó', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (22, N'Horizonte', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (23, N'Camocim', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (24, N'Acaraú', 1, 31, 226)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (25, N'Morada Nova', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (26, N'Viçosa do Ceará', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (27, N'Barbalha', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (28, N'Limoeiro do Norte', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (29, N'Tauá', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (30, N'Trairi', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (31, N'Granja', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (32, N'Boa Viagem', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (33, N'Acopiara', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (34, N'Eusébio', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (35, N'Beberibe', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (36, N'Itapajé', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (37, N'Brejo Santo', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (38, N'São Gonçalo do Amarante', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (39, N'Mauriti', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (40, N'São Benedito', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (41, N'Mombaça', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (42, N'Santa Quitéria', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (43, N'Amontada', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (44, N'Pedra Branca', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (45, N'Ipu', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (46, N'Itarema', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (47, N'Várzea Alegre', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (48, N'Guaraciaba do Norte', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (49, N'Massapê', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (50, N'Ipueiras', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (51, N'Itaitinga', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (52, N'Pentecoste', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (53, N'Missão Velha', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (54, N'Baturité', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (55, N'Paracuru', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (56, N'Ubajara', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (57, N'Jaguaribe', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (58, N'Jaguaruana', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (59, N'Paraipaba', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (60, N'Bela Cruz', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (61, N'Nova Russas', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (62, N'Santana do Acaraú', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (63, N'Parambu', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (64, N'Lavras da Mangabeira', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (65, N'Tabuleiro do Norte', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (66, N'Redenção', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (67, N'Novo Oriente', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (68, N'Milagres', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (69, N'Campos Sales', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (70, N'Jardim', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (71, N'Marco', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (72, N'Caririaçu', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (73, N'Senador Pompeu', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (74, N'Aracoiaba', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (75, N'Guaiúba', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (76, N'Independência', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (77, N'Tamboril', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (78, N'Ocara', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (79, N'Cedro', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (80, N'Ibiapina', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (81, N'Jucás', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (82, N'Aurora', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (83, N'Cruz', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (84, N'Forquilha', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (85, N'Irauçuba', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (86, N'Assaré', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (87, N'Coreaú', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (88, N'Barro', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (89, N'Caridade', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (90, N'Morrinhos', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (91, N'Barreira', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (92, N'Quixeré', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (93, N'Uruburetama', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (94, N'Itatira', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (95, N'Araripe', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (96, N'Orós', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (97, N'Quiterianópolis', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (98, N'Catarina', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (99, N'Pindoretama', 1, 6, 31)
GO
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (100, N'Itapiúna', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (101, N'Chorozinho', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (102, N'Hidrolândia', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (103, N'Icapuí', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (104, N'Umirim', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (105, N'Jijoca de Jericoacoara', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (106, N'Madalena', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (107, N'Farias Brito', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (108, N'Tejuçuoca', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (109, N'Cariús', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (110, N'Reriutaba', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (111, N'Cariré', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (112, N'Varjota', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (113, N'Solonópole', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (114, N'Banabuiú', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (115, N'Jaguaretama', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (116, N'Croatá', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (117, N'Capistrano', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (118, N'Santana do Cariri', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (119, N'Carnaubal', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (120, N'Aiuaba', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (121, N'Monsenhor Tabosa', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (122, N'Alto Santo', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (123, N'Piquet Carneiro', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (124, N'Salitre', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (125, N'Fortim', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (126, N'Pereiro', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (127, N'Tururu', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (128, N'Quixelô', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (129, N'Saboeiro', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (130, N'Nova Olinda', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (131, N'Meruoca', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (132, N'Barroquinha', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (133, N'Porteiras', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (134, N'Acarape', 1, 32, 114)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (135, N'Apuiarés', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (136, N'Mucambo', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (137, N'Graça', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (138, N'Iracema', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (139, N'Frecheirinha', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (140, N'Uruoca', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (141, N'Miraíma', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (142, N'Choró', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (143, N'Ibaretama', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (144, N'Palmácia', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (145, N'Milhã', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (146, N'Chaval', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (147, N'São Luís do Curu', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (148, N'Ibicuitinga', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (149, N'Ipaumirim', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (150, N'Poranga', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (151, N'Pacoti', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (152, N'Paramoti', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (153, N'Aratuba', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (154, N'Abaiara', 1, 31, 226)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (155, N'Alcântaras', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (156, N'Ipaporanga', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (157, N'Jaguaribara', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (158, N'Martinópole', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (159, N'Groaíras', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (160, N'Potengi', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (161, N'Pires Ferreira', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (162, N'Ararendá', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (163, N'Mulungu', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (164, N'Catunda', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (165, N'Deputado Irapuan Pinheiro', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (166, N'Palhano', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (167, N'Penaforte', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (168, N'Tarrafas', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (169, N'Moraújo', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (170, N'Jati', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (171, N'Arneiroz', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (172, N'Itaiçaba', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (173, N'Umari', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (174, N'São João do Jaguaribe', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (175, N'General Sampaio', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (176, N'Senador Sá', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (177, N'Altaneira', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (178, N'Antonina do Norte', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (179, N'Ererê', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (180, N'Pacujá', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (181, N'Potiretama', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (182, N'Baixio', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (183, N'Guaramiranga', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (184, N'Granjeiro', 1, 6, 31)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (1205, N'tiago', 1, 32, 114)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (1225, N'Copos', 1, 33, 242)
INSERT [dbo].[cidade] ([id], [nome], [ativo], [id_estado], [id_pais]) VALUES (1226, N'Logos', 1, 31, 226)
SET IDENTITY_INSERT [dbo].[cidade] OFF
SET IDENTITY_INSERT [dbo].[estado] ON 

INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (1, N'Acre', N'AC', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (2, N'Alagoas', N'AL', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (3, N'Amapá', N'AP', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (4, N'Amazonas', N'AM', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (6, N'Ceará', N'CE', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (7, N'Distrito Federal*', N'DF', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (8, N'Espírito Santo', N'ES', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (9, N'Goiás', N'GO', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (10, N'Maranhão', N'MA', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (11, N'Mato Grosso', N'MT', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (12, N'Mato Grosso do Sul', N'MS', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (13, N'Minas Gerais', N'MG', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (14, N'Pará', N'PA', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (15, N'Paraíba', N'PB', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (16, N'Paraná', N'PR', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (17, N'Pernambuco', N'PE', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (18, N'Piauí', N'PI', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (19, N'Rio de Janeiro', N'RJ', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (20, N'Rio Grande do Norte', N'RN', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (21, N'Rio Grande do Sul', N'RS', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (22, N'Rondônia', N'RO', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (23, N'Roraima', N'RR', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (24, N'Santa Catarina', N'SC', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (25, N'São Paulo', N'SP', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (26, N'Sergipe', N'SE', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (27, N'Tocantins', N'TO', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (28, N'Bahiaa', N'BA', 1, 31)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (31, N'New York', N'NW', 1, 226)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (32, N'Tokio', N'TK', 1, 114)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (33, N'Lagos', N'LG', 1, 242)
INSERT [dbo].[estado] ([id], [nome], [uf], [ativo], [id_pais]) VALUES (35, N'Alabama', N'AL', 1, 226)
SET IDENTITY_INSERT [dbo].[estado] OFF
SET IDENTITY_INSERT [dbo].[fornecedor] ON 

INSERT [dbo].[fornecedor] ([id], [nome], [razao_social], [num_documento], [tipo], [telefone], [contato], [logradouro], [numero], [complemento], [cep], [id_pais], [id_estado], [id_cidade], [ativo]) VALUES (1, N'Ronaldo Mercadinho Logos', N'5646', N'56465465487', 0, N'85 9.9429-9382', N'85 9.9429-9382', N'Travessa Padre José Maria', N'199', N'Loja', N'62598-000', 31, 6, 2, 1)
INSERT [dbo].[fornecedor] ([id], [nome], [razao_social], [num_documento], [tipo], [telefone], [contato], [logradouro], [numero], [complemento], [cep], [id_pais], [id_estado], [id_cidade], [ativo]) VALUES (2, N'Felipe Souza', N'Felipe Souza', N'053.236.913-01', 1, N'(85) 9942-9938', N'(85) 9942-9938', N'Travessa Padre José Maria', N'199', N'', N'62598-000', 31, 6, 105, 1)
SET IDENTITY_INSERT [dbo].[fornecedor] OFF
SET IDENTITY_INSERT [dbo].[grupo_produto] ON 

INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (4, N'1111''); update grupo_produto set nome= 444 --', 1)
INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (9, N'22222', 1)
INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (11, N'444', 1)
INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (12, N'555', 1)
INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (13, N'555', 1)
INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (14, N'666', 1)
INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (16, N'777777', 1)
INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (19, N'88888', 1)
INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (20, N'9999', 1)
INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (29, N'8888888888888888888', 1)
INSERT [dbo].[grupo_produto] ([id], [nome], [ativo]) VALUES (30, N'bfiubibfs', 1)
SET IDENTITY_INSERT [dbo].[grupo_produto] OFF
SET IDENTITY_INSERT [dbo].[local_armazenamento] ON 

INSERT [dbo].[local_armazenamento] ([id], [nome], [ativo]) VALUES (4, N'Depósito Caucaia', 1)
SET IDENTITY_INSERT [dbo].[local_armazenamento] OFF
SET IDENTITY_INSERT [dbo].[marca_produto] ON 

INSERT [dbo].[marca_produto] ([id], [nome], [ativo]) VALUES (4, N'Soart', 1)
SET IDENTITY_INSERT [dbo].[marca_produto] OFF
SET IDENTITY_INSERT [dbo].[pais] ON 

INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (1, N'Afghanistão', N'AFG', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (2, N'ÁfricadoSul', N'ZAF', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (3, N'Albânia', N'ALB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (4, N'Alemanha', N'DEU', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (5, N'Andora', N'AND', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (6, N'Angola', N'AGO', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (7, N'Anguilla', N'AIA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (8, N'Antarctica', N'ATA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (9, N'AntíguaeBarbuda', N'ATG', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (10, N'Argentina', N'ARG', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (11, N'Argélia', N'DZA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (12, N'Arménia', N'ARM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (13, N'Aruba', N'ABW', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (14, N'ArábiaSaudita', N'SAU', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (15, N'Austrália', N'AUS', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (16, N'Áustria', N'AUT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (17, N'Azerbaijão', N'AZE', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (18, N'Bahamas', N'BHS', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (19, N'Bahrein', N'BHR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (20, N'Bangladesh', N'BGD', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (21, N'Barbados', N'BRB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (22, N'Bélgica', N'BEL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (23, N'Belize', N'BLZ', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (24, N'Benim', N'BEN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (25, N'Bermuda', N'BMU', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (26, N'Butão', N'BTN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (27, N'Bielorrússia', N'BLR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (28, N'Bolívia', N'BOL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (29, N'BósniaeHerzegovina', N'BIH', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (30, N'Botswana', N'BWA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (31, N'Brasil', N'BRA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (32, N'BritishIndianOceanTerritory', N'IOT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (33, N'Brunei', N'BRN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (34, N'Bulgária', N'BGR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (35, N'BurkinaFaso', N'BFA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (36, N'Myanmar(Burma)', N'MMR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (37, N'Burundi', N'BDI', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (38, N'Camarões', N'CMR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (39, N'CaboVerde', N'CPV', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (40, N'Camboja', N'KHM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (41, N'Canadá', N'CAN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (42, N'Catar', N'QAT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (43, N'Chad', N'TCD', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (44, N'Chile', N'CHL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (45, N'China', N'CHN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (46, N'Chipre', N'CYP', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (47, N'ChristmasIsland', N'CXR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (48, N'Cingapura', N'SGP', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (49, N'Colômbia', N'COL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (50, N'Comores', N'COM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (51, N'CoreiadoNorte', N'PRK', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (52, N'CoreiadoSul', N'KOR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (53, N'CostadoMarfim', N'CIV', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (54, N'CostaRica', N'CRC', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (55, N'Croácia', N'HRV', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (56, N'Cuba', N'CUB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (57, N'Dinamarca', N'DNK', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (58, N'Djibouti', N'DJI', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (59, N'Dominica', N'DMA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (60, N'Egito', N'EGY', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (61, N'ElSalvador', N'SLV', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (62, N'EmiradosÁrabesUnidos', N'ARE', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (63, N'Equador', N'ECU', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (64, N'Eritreia', N'ERI', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (65, N'Estónia', N'EST', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (66, N'Espanha', N'ESP', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (67, N'Etiópia', N'ETH', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (68, N'Fiji', N'FJI', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (69, N'Finlândia', N'FIN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (70, N'França', N'FRA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (71, N'Gabão', N'GAB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (72, N'Gâmbia', N'GMB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (73, N'BandadeGaza', N'BGP', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (74, N'Geórgia', N'GEO', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (75, N'Gana', N'GHA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (76, N'Gibraltar', N'GIB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (77, N'Grécia', N'GRC', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (78, N'Groelândia', N'GRL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (79, N'Granada', N'GRD', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (80, N'Guam', N'GUM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (81, N'Guatemala', N'GTM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (82, N'Guiana', N'GUY', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (83, N'Guiné', N'GIN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (84, N'GuinéEquatorial', N'GNQ', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (85, N'Guiné-Bissau', N'GNB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (86, N'Haiti', N'HTI', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (87, N'Honduras', N'HND', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (88, N'HongKong', N'HKG', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (89, N'Hungria', N'HUN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (90, N'Islândia', N'ISL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (91, N'IlhasCayman', N'CYM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (92, N'IlhasCocos(Keeling)', N'CCK', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (93, N'IlhadeMan', N'IMN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (94, N'IlhasCook', N'COK', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (95, N'IlhasFalkland(Malvinas)', N'FLK', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (96, N'IlhasFeroé', N'FRO', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (97, N'IlhasMarianadoNorte', N'MNP', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (98, N'IlhasMarshall', N'MHL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (99, N'IlhasNorfolk', N'NFK', 1)
GO
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (100, N'IlhasPitcairn', N'PCN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (101, N'IlhasSalomão', N'SLB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (102, N'IlhasTurcaseCaicos', N'TCA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (103, N'IlhasVirgensAmericanas', N'VIR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (104, N'IlhasVirgensBritânicas', N'VGB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (105, N'India', N'IND', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (106, N'Indonésia', N'IDN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (107, N'Inglaterra(ReinoUnido)', N'GBR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (108, N'Irã', N'IRN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (109, N'Iraque', N'IRQ', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (110, N'Irlanda', N'IRL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (111, N'Israel', N'ISR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (112, N'Itália', N'ITA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (113, N'Jamaica', N'JAM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (114, N'Japão', N'JPN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (115, N'Jersey', N'JEY', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (116, N'Jordânia', N'JOR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (117, N'Cazaquistão', N'KAZ', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (118, N'Quénia(Kenya)', N'KEN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (119, N'Kiribati', N'KIR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (120, N'Kosovo', N'KOS', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (121, N'Kuwait', N'KWT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (122, N'Quirguistão', N'KGZ', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (123, N'Laos', N'LAO', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (124, N'Letônia', N'LVA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (125, N'Líbano', N'LBN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (126, N'Lesoto', N'LSO', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (127, N'Libéria', N'LBR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (128, N'Líbia', N'LBY', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (129, N'Liechtenstein', N'LIE', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (130, N'Lituânia', N'LTU', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (131, N'Luxemburgo', N'LUX', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (132, N'Macau', N'MAC', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (133, N'Macedónia', N'MKD', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (134, N'Madagáscar', N'MDG', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (135, N'Malawi', N'MWI', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (136, N'Malásia', N'MYS', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (137, N'Maldivas', N'MDV', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (138, N'Mali', N'MLI', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (139, N'Malta', N'MLT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (140, N'Mauritânia', N'MRT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (141, N'Maurícia', N'MUS', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (142, N'Mayotte', N'MYT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (143, N'México', N'MEX', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (144, N'Micronésia', N'FSM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (145, N'Moldávia', N'MDA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (146, N'Monaco', N'MCO', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (147, N'Mongólia', N'MNG', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (148, N'Montenegro', N'MNE', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (149, N'Montserrat', N'MSR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (150, N'Marrocos', N'MAR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (151, N'Moçambique', N'MOZ', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (152, N'Namíbia', N'NAM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (153, N'Nauru', N'NRU', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (154, N'Nepal', N'NPL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (155, N'NetherlandsAntilles', N'ANT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (156, N'NovaCaledônia', N'NCL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (157, N'NovaZelândia', N'NZL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (158, N'Nicaragua', N'NIC', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (159, N'Níger', N'NER', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (160, N'Nigéria', N'NGA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (161, N'Niue', N'NIU', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (162, N'Noruega', N'NOR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (163, N'Omã', N'OMN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (164, N'PaísesBaixos', N'NLD', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (165, N'Paquistão', N'PAK', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (166, N'Palau', N'PLW', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (167, N'Panamá', N'PAN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (168, N'Papua-NovaGuiné', N'PNG', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (169, N'Paraguai', N'PRY', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (170, N'Peru', N'PER', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (171, N'Filipinas', N'PHL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (172, N'Polónia', N'POL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (173, N'PolinésiaFrancesa', N'PYF', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (174, N'Portugal', N'PRT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (175, N'PortoRico', N'PRI', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (176, N'RepúblicadoCongo', N'COG', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (177, N'RepúblicaDemocráticadoCongo', N'COD', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (178, N'RepúblicaCentro-Africana', N'CAF', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (179, N'RepúblicaCheca', N'CZE', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (180, N'RepúblicaDominicana', N'DOM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (181, N'Roménia', N'ROU', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (182, N'Ruanda', N'RWA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (183, N'Rússia', N'RUS', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (184, N'SaintBarthelemy', N'BLM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (185, N'Samoa', N'WSM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (186, N'SamoaAmericana', N'ASM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (187, N'SanMarino', N'SMR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (188, N'SaoTomeePrincipe', N'STP', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (189, N'Senegal', N'SEN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (190, N'Serbia', N'SRB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (191, N'SerraLeoa', N'SLE', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (192, N'Seychelles', N'SYC', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (193, N'Slovakia', N'SVK', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (194, N'Slovenia', N'SVN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (195, N'Somalia', N'SOM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (196, N'SriLanka', N'LKA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (197, N'SaintHelena', N'SHN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (198, N'SaintKittsandNevis', N'KNA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (199, N'SaintLucia', N'LCA', 1)
GO
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (200, N'SaintMartin', N'MAF', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (201, N'SaintPierreandMiquelon', N'SPM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (202, N'SaintVincentandtheGrenadines', N'VCT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (203, N'Sudão', N'SDN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (204, N'Suriname', N'SUR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (205, N'Svalbard', N'SJM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (206, N'Suazilândia', N'SWZ', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (207, N'Suécia', N'SWE', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (208, N'Suiça', N'CHE', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (209, N'Syria', N'SYR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (210, N'Taiwan', N'TWN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (211, N'Tajiquistão', N'TJK', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (212, N'Tanzânia', N'TZA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (213, N'Timor-Leste', N'TLS', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (214, N'Tailândia', N'THA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (215, N'Togo', N'TGO', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (216, N'Tokelau', N'TKL', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (217, N'Tonga', N'TON', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (218, N'TrinidadeTobago', N'TTO', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (219, N'Tunísia', N'TUN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (220, N'Turquemenistão', N'TKM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (221, N'Turquia', N'TUR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (222, N'Tuvalu', N'TUV', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (223, N'Uganda', N'UGA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (224, N'Ucrânia', N'UKR', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (225, N'Uruguai', N'URY', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (226, N'EstadosUnidos(EUA)', N'USA', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (227, N'Uzbequistão', N'UZB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (228, N'Vanuatu', N'VUT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (229, N'Vaticano', N'VAT', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (230, N'Venezuela', N'VEN', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (231, N'Vietnã(Vietname)', N'VNM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (232, N'WalliseFutuna', N'WLF', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (233, N'WestBank', N'WTB', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (234, N'WesternSahara', N'ESH', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (235, N'Iémen(Iémen,Yemen)', N'YEM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (236, N'Zimbabwe(Zimbabué)', N'ZWE', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (237, N'Zâmbia', N'ZAM', 1)
INSERT [dbo].[pais] ([id], [nome], [codigo], [ativo]) VALUES (242, N'Targeria', N'TGR', 1)
SET IDENTITY_INSERT [dbo].[pais] OFF
SET IDENTITY_INSERT [dbo].[perfil] ON 

INSERT [dbo].[perfil] ([id], [nome], [ativo]) VALUES (1, N'Gerente', 1)
INSERT [dbo].[perfil] ([id], [nome], [ativo]) VALUES (2, N'Administrativo', 1)
INSERT [dbo].[perfil] ([id], [nome], [ativo]) VALUES (3, N'Operador', 1)
SET IDENTITY_INSERT [dbo].[perfil] OFF
SET IDENTITY_INSERT [dbo].[perfil_usuario] ON 

INSERT [dbo].[perfil_usuario] ([id], [id_perfil], [id_usuario]) VALUES (4, 3, 5)
INSERT [dbo].[perfil_usuario] ([id], [id_perfil], [id_usuario]) VALUES (10, 1, 1)
SET IDENTITY_INSERT [dbo].[perfil_usuario] OFF
SET IDENTITY_INSERT [dbo].[unidade_medida] ON 

INSERT [dbo].[unidade_medida] ([id], [nome], [sigla], [ativo]) VALUES (1, N'Peça', N'PT', 1)
SET IDENTITY_INSERT [dbo].[unidade_medida] OFF
SET IDENTITY_INSERT [dbo].[usuario] ON 

INSERT [dbo].[usuario] ([id], [login], [senha], [nome], [id_perfil], [email]) VALUES (1, N'josy', N'698d51a19d8a121ce581499d7b701668', N'Josy Frota', 1, N'felipesoart@gmail.com')
INSERT [dbo].[usuario] ([id], [login], [senha], [nome], [id_perfil], [email]) VALUES (2, N'felipe', N'698d51a19d8a121ce581499d7b701668', N'Felipe Souza', 1, N'felipesoart@hotmail.com')
INSERT [dbo].[usuario] ([id], [login], [senha], [nome], [id_perfil], [email]) VALUES (5, N'nana', N'202cb962ac59075b964b07152d234b70', N'Nana Cat', 3, N'josygatamix2021@hotmail.com')
SET IDENTITY_INSERT [dbo].[usuario] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [unique_usuario_email]    Script Date: 12/05/2021 21:01:10 ******/
ALTER TABLE [dbo].[usuario] ADD  CONSTRAINT [unique_usuario_email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cidade]  WITH CHECK ADD  CONSTRAINT [FK__cidade__id_estad__531856C7] FOREIGN KEY([id_estado])
REFERENCES [dbo].[estado] ([id])
GO
ALTER TABLE [dbo].[cidade] CHECK CONSTRAINT [FK__cidade__id_estad__531856C7]
GO
ALTER TABLE [dbo].[cidade]  WITH CHECK ADD  CONSTRAINT [FK__cidade__id_pais__607251E5] FOREIGN KEY([id_pais])
REFERENCES [dbo].[pais] ([id])
GO
ALTER TABLE [dbo].[cidade] CHECK CONSTRAINT [FK__cidade__id_pais__607251E5]
GO
ALTER TABLE [dbo].[estado]  WITH CHECK ADD FOREIGN KEY([id_pais])
REFERENCES [dbo].[pais] ([id])
GO
ALTER TABLE [dbo].[fornecedor]  WITH CHECK ADD  CONSTRAINT [FK__fornecedo__id_ci__7755B73D] FOREIGN KEY([id_cidade])
REFERENCES [dbo].[cidade] ([id])
GO
ALTER TABLE [dbo].[fornecedor] CHECK CONSTRAINT [FK__fornecedo__id_ci__7755B73D]
GO
ALTER TABLE [dbo].[fornecedor]  WITH CHECK ADD  CONSTRAINT [FK__fornecedo__id_es__76619304] FOREIGN KEY([id_estado])
REFERENCES [dbo].[estado] ([id])
GO
ALTER TABLE [dbo].[fornecedor] CHECK CONSTRAINT [FK__fornecedo__id_es__76619304]
GO
ALTER TABLE [dbo].[fornecedor]  WITH CHECK ADD  CONSTRAINT [FK__fornecedo__id_pa__756D6ECB] FOREIGN KEY([id_pais])
REFERENCES [dbo].[pais] ([id])
GO
ALTER TABLE [dbo].[fornecedor] CHECK CONSTRAINT [FK__fornecedo__id_pa__756D6ECB]
GO
ALTER TABLE [dbo].[perfil_usuario]  WITH CHECK ADD FOREIGN KEY([id_perfil])
REFERENCES [dbo].[perfil] ([id])
GO
ALTER TABLE [dbo].[perfil_usuario]  WITH CHECK ADD FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuario] ([id])
GO
ALTER TABLE [dbo].[usuario]  WITH CHECK ADD FOREIGN KEY([id_perfil])
REFERENCES [dbo].[perfil] ([id])
GO
