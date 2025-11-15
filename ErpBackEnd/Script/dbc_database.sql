USE [dbc01y30]
GO
/****** Object:  Table [dbo].[apclass]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[apclass](
	[cl_company] [char](2) NOT NULL,
	[cl_code] [char](2) NOT NULL,
	[cl_desc] [varchar](50) NOT NULL,
	[cl_crlser] [char](19) NOT NULL,
	[cl_dscser] [char](19) NOT NULL,
	[cl_salser] [char](19) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[modified] [bit] NOT NULL,
	[cl_ldesc] [varchar](50) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[cstcode] [char](4) NULL,
	[classkey] [char](2) NULL,
 CONSTRAINT [PK_apclass] PRIMARY KEY CLUSTERED 
(
	[cl_company] ASC,
	[cl_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[apdtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[apdtl](
	[dt_company] [char](2) NOT NULL,
	[dt_type] [char](2) NOT NULL,
	[dt_ref] [numeric](6, 0) NOT NULL,
	[dt_date] [char](8) NOT NULL,
	[dt_lcamt] [float] NOT NULL,
	[dt_paidamt] [float] NOT NULL,
	[dt_discamt] [float] NOT NULL,
	[dt_cucode] [char](6) NOT NULL,
	[dt_fcy] [char](3) NOT NULL,
	[dt_trxsrc] [char](2) NOT NULL,
	[dt_fcamt] [float] NOT NULL,
	[dt_fpydamt] [float] NOT NULL,
	[dt_fdscamt] [float] NOT NULL,
	[dt_lcaloc] [float] NOT NULL,
	[dt_fcaloc] [float] NOT NULL,
	[dt_aloctd] [char](1) NOT NULL,
	[dt_pdinv] [numeric](6, 0) NOT NULL,
	[dt_duedate] [char](8) NOT NULL,
	[dt_desc] [varchar](70) NOT NULL,
	[dt_chkno] [char](8) NOT NULL,
	[dt_chkdate] [char](8) NOT NULL,
	[dt_chkbnk] [char](2) NOT NULL,
	[dt_dbcr] [char](1) NOT NULL,
	[dt_ackey] [char](19) NOT NULL,
	[dt_folio] [numeric](4, 0) NOT NULL,
	[dt_rcvno] [numeric](6, 0) NOT NULL,
	[dt_lstdate] [char](8) NOT NULL,
	[tdscdays] [numeric](3, 0) NULL,
	[tdscpcs] [numeric](5, 2) NOT NULL,
	[match] [bit] NOT NULL,
	[rplct_post] [bit] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_apdtl] PRIMARY KEY CLUSTERED 
(
	[dt_company] ASC,
	[dt_type] ASC,
	[dt_ref] ASC,
	[dt_folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[aphdr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aphdr](
	[hd_company] [char](2) NOT NULL,
	[hd_type] [char](2) NOT NULL,
	[hd_ref] [numeric](6, 0) NOT NULL,
	[hd_date] [char](8) NOT NULL,
	[hd_fcy] [char](3) NOT NULL,
	[hd_ftotal] [float] NOT NULL,
	[hd_fcyrate] [float] NULL,
	[hd_ltotal] [float] NOT NULL,
	[hd_cucode] [char](6) NOT NULL,
	[hd_desc1] [varchar](70) NOT NULL,
	[hd_ser] [char](19) NOT NULL,
	[hd_rlsd] [bit] NOT NULL,
	[hd_posted] [bit] NOT NULL,
	[hd_trxsrc] [char](2) NOT NULL,
	[hd_sysdate] [char](8) NOT NULL,
	[hd_lcnet] [float] NOT NULL,
	[hd_fcnet] [float] NOT NULL,
	[hd_lccnet] [float] NOT NULL,
	[hd_fccnet] [float] NOT NULL,
	[isit_opst] [bit] NOT NULL,
	[opst_val] [float] NOT NULL,
	[opst_fcy] [char](3) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[modified] [bit] NOT NULL,
	[rcvdtrn] [bit] NOT NULL,
	[usrid] [char](10) NOT NULL,
	[clcode] [char](2) NOT NULL,
	[clcmnd] [bit] NOT NULL,
	[dscamt] [float] NOT NULL,
	[payinv] [bit] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[bankref] [char](20) NULL,
 CONSTRAINT [PK_aphdr] PRIMARY KEY CLUSTERED 
(
	[hd_company] ASC,
	[hd_type] ASC,
	[hd_ref] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ardtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ardtl](
	[dt_company] [char](2) NOT NULL,
	[dt_type] [char](2) NOT NULL,
	[dt_ref] [numeric](6, 0) NOT NULL,
	[dt_date] [char](8) NOT NULL,
	[dt_lcamt] [float] NULL,
	[dt_paidamt] [float] NULL,
	[dt_discamt] [float] NULL,
	[dt_cucode] [char](6) NOT NULL,
	[dt_fcy] [char](3) NOT NULL,
	[dt_trxsrc] [char](2) NOT NULL,
	[dt_fcamt] [float] NULL,
	[dt_fpydamt] [float] NULL,
	[dt_fdscamt] [float] NULL,
	[dt_lcaloc] [float] NULL,
	[dt_fcaloc] [float] NULL,
	[dt_aloctd] [char](1) NOT NULL,
	[dt_pdinv] [numeric](6, 0) NOT NULL,
	[dt_duedate] [char](8) NOT NULL,
	[dt_desc] [varchar](70) NOT NULL,
	[dt_chkno] [char](8) NOT NULL,
	[dt_chkdate] [char](8) NOT NULL,
	[dt_chkbnk] [char](2) NOT NULL,
	[dt_dbcr] [char](1) NOT NULL,
	[dt_ackey] [char](19) NOT NULL,
	[dt_folio] [numeric](3, 0) NOT NULL,
	[dt_rcvno] [numeric](6, 0) NOT NULL,
	[dt_lstdate] [char](8) NOT NULL,
	[tdscdays] [numeric](2, 0) NULL,
	[tdscpcs] [numeric](4, 2) NULL,
	[match] [bit] NOT NULL,
	[rplct_post] [bit] NULL,
 CONSTRAINT [PK_ardtl] PRIMARY KEY CLUSTERED 
(
	[dt_company] ASC,
	[dt_type] ASC,
	[dt_ref] ASC,
	[dt_folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[arhdr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[arhdr](
	[hd_company] [char](2) NOT NULL,
	[hd_type] [char](2) NOT NULL,
	[hd_ref] [numeric](6, 0) NOT NULL,
	[hd_date] [char](8) NOT NULL,
	[hd_fcy] [char](3) NOT NULL,
	[hd_ftotal] [float] NULL,
	[hd_fcyrate] [float] NULL,
	[hd_ltotal] [float] NULL,
	[hd_cucode] [char](6) NOT NULL,
	[hd_desc1] [varchar](70) NOT NULL,
	[hd_ser] [char](19) NOT NULL,
	[hd_rlsd] [bit] NOT NULL,
	[hd_posted] [bit] NOT NULL,
	[hd_trxsrc] [char](2) NOT NULL,
	[hd_sysdate] [char](8) NOT NULL,
	[hd_lcnet] [float] NULL,
	[hd_fcnet] [float] NULL,
	[hd_lccnet] [float] NULL,
	[hd_fccnet] [float] NULL,
	[isit_opst] [bit] NOT NULL,
	[opst_val] [float] NULL,
	[opst_fcy] [char](3) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[modified] [bit] NOT NULL,
	[rcvdtrn] [bit] NOT NULL,
	[usrid] [char](10) NOT NULL,
	[clcode] [char](2) NOT NULL,
	[clcmnd] [bit] NOT NULL,
	[dscamt] [float] NULL,
	[payinv] [bit] NOT NULL,
	[discountedBill] [bit] NULL,
 CONSTRAINT [PK_arhdr] PRIMARY KEY CLUSTERED 
(
	[hd_company] ASC,
	[hd_type] ASC,
	[hd_ref] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[classfil]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[classfil](
	[cl_company] [char](2) NOT NULL,
	[cl_code] [char](2) NOT NULL,
	[cl_desc] [varchar](30) NOT NULL,
	[cl_crlser] [char](19) NOT NULL,
	[cl_dscser] [char](19) NOT NULL,
	[cl_salser] [char](19) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[modified] [bit] NOT NULL,
	[cl_ldesc] [varchar](30) NOT NULL,
	[cstcode] [char](4) NULL,
 CONSTRAINT [PK_classfil] PRIMARY KEY CLUSTERED 
(
	[cl_company] ASC,
	[cl_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[cu_name] [varchar](60) NOT NULL,
	[cu_company] [char](2) NOT NULL,
	[cu_code] [char](6) NOT NULL,
	[cu_class] [char](2) NOT NULL,
	[cu_addrs] [varchar](50) NOT NULL,
	[cu_tel] [varchar](30) NOT NULL,
	[cu_fax] [varchar](50) NOT NULL,
	[cu_tlx] [varchar](50) NOT NULL,
	[cu_email] [varchar](30) NOT NULL,
	[cu_cntactp] [varchar](50) NOT NULL,
	[cu_title] [varchar](50) NOT NULL,
	[cu_crlmt] [numeric](14, 2) NOT NULL,
	[cu_pymnt] [numeric](3, 0) NOT NULL,
	[cu_status] [numeric](1, 0) NOT NULL,
	[cu_opnbal] [float] NULL,
	[cu_curbal] [float] NULL,
	[cf_fcy] [char](3) NOT NULL,
	[cf_opnfcy] [float] NULL,
	[cf_curfcy] [float] NULL,
	[cu_xrf] [char](6) NOT NULL,
	[cu_alwcr] [bit] NOT NULL,
	[cu_ctlser] [char](19) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[cu_lcaloc] [float] NULL,
	[cu_fcaloc] [float] NULL,
	[cu_instlmnt] [numeric](11, 2) NOT NULL,
	[cu_instldays] [numeric](2, 0) NOT NULL,
	[cu_install] [bit] NOT NULL,
	[modified] [bit] NOT NULL,
	[cmncode] [char](8) NOT NULL,
	[cu_lname] [varchar](40) NOT NULL,
	[cu_city] [char](6) NOT NULL,
	[cu_type] [char](1) NOT NULL,
	[cu_laddrs] [varchar](50) NOT NULL,
	[cu_carrier] [char](3) NOT NULL,
	[cu_mobile] [varchar](50) NOT NULL,
	[section] [char](6) NULL,
	[cu_sendsms] [bit] NULL,
	[cu_onlycsh] [bit] NULL,
	[clnt_taxcode] [varchar](20) NULL,
	[taxFree] [bit] NULL,
	[cu_kind] [char](1) NULL,
	[ok_free] [bit] NULL,
	[ok_no_pay] [bit] NULL,
	[ok_no_down_payment] [bit] NULL,
	[exduplimit] [bit] NULL,
	[individual_clnt] [bit] NULL,
	[cu_invdsc] [numeric](7, 3) NULL,
	[slcode] [char](2) NULL,
	[lst_inv_excd_duedate] [bit] NULL,
	[usrid] [char](10) NULL,
	[usridchg] [char](10) NULL,
	[Added_date] [char](8) NULL,
	[location] [varchar](100) NULL,
 CONSTRAINT [PK_customer_1] PRIMARY KEY CLUSTERED 
(
	[cu_company] ASC,
	[cu_code] ASC,
	[cf_fcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer_ei]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_ei](
	[cu_company] [char](2) NOT NULL,
	[cu_code] [varchar](20) NOT NULL,
	[cf_fcy] [char](3) NOT NULL,
	[district] [varchar](50) NULL,
	[district_l] [varchar](50) NULL,
	[city_text] [varchar](50) NULL,
	[city_text_l] [varchar](50) NULL,
	[country_code] [numeric](3, 0) NULL,
	[postal_code] [varchar](20) NULL,
	[Other_id_SchemeID] [varchar](20) NULL,
	[bldg_no] [varchar](50) NULL,
	[bldg_no_l] [varchar](50) NULL,
	[street_name] [varchar](50) NULL,
	[street_name_l] [varchar](50) NULL,
	[area_name] [varchar](50) NULL,
	[area_name_l] [varchar](50) NULL,
	[extra_address_no] [varchar](50) NULL,
	[extra_address_no_l] [varchar](50) NULL,
	[street_name2] [varchar](50) NULL,
	[street_name2_l] [varchar](50) NULL,
	[Group_VAT_ID] [varchar](30) NULL,
	[Other_Scheme_Type] [varchar](10) NULL,
	[client_name] [varchar](50) NULL,
	[client_mobile] [varchar](15) NULL,
	[country_text] [varchar](50) NULL,
	[country_text_l] [varchar](50) NULL,
 CONSTRAINT [PK_customer_ei] PRIMARY KEY CLUSTERED 
(
	[cu_company] ASC,
	[cu_code] ASC,
	[cf_fcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[glchart]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glchart](
	[glname] [varchar](50) NOT NULL,
	[glkey] [char](19) NOT NULL,
	[glcomp] [char](2) NOT NULL,
	[glcurbal] [float] NULL,
	[glopnbal] [float] NULL,
	[glopndate] [char](8) NULL,
	[glamnd] [char](8) NULL,
	[glacttyp] [char](1) NOT NULL,
	[glgroup] [char](1) NOT NULL,
	[glactive] [char](1) NOT NULL,
	[glpurge] [char](1) NULL,
	[accontrol] [bit] NOT NULL,
	[glp_lcode] [char](1) NOT NULL,
	[glcurrency] [char](3) NOT NULL,
	[glbal01] [float] NULL,
	[glbal02] [float] NULL,
	[glbal03] [float] NULL,
	[glbal04] [float] NULL,
	[glbal05] [float] NULL,
	[glbal06] [float] NULL,
	[glbal07] [float] NULL,
	[glbal08] [float] NULL,
	[glbal09] [float] NULL,
	[glbal10] [float] NULL,
	[glbal11] [float] NULL,
	[glbal12] [float] NULL,
	[glbal13] [float] NULL,
	[fccurbal] [numeric](13, 2) NULL,
	[fcopnbal] [numeric](13, 2) NULL,
	[fcbal01] [numeric](13, 2) NULL,
	[fcbal02] [numeric](13, 2) NULL,
	[fcbal03] [numeric](13, 2) NULL,
	[fcbal04] [numeric](13, 2) NULL,
	[fcbal05] [numeric](13, 2) NULL,
	[fcbal06] [numeric](13, 2) NULL,
	[fcbal07] [numeric](13, 2) NULL,
	[fcbal08] [numeric](13, 2) NULL,
	[fcbal09] [numeric](13, 2) NULL,
	[fcbal10] [numeric](13, 2) NULL,
	[fcbal11] [numeric](13, 2) NULL,
	[fcbal12] [numeric](13, 2) NULL,
	[fcbal13] [numeric](13, 2) NULL,
	[glsgrp] [char](1) NOT NULL,
	[imopnbal] [float] NOT NULL,
	[imcurbal] [float] NOT NULL,
	[lastupdt] [char](8) NULL,
	[gleval] [bit] NULL,
	[acprotect] [bit] NULL,
	[pkey] [numeric](5, 0) NULL,
	[chkey] [numeric](5, 0) NULL,
	[cashbnk] [bit] NULL,
	[modified] [bit] NULL,
	[gllname] [varchar](50) NULL,
	[section] [char](6) NULL,
	[isbracc] [bit] NULL,
	[actlvl] [int] NULL,
	[glackind] [char](1) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[usrid] [char](10) NULL,
	[usridchg] [char](10) NULL,
 CONSTRAINT [PK_glchart_1] PRIMARY KEY CLUSTERED 
(
	[glkey] ASC,
	[glcurrency] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[glcstctr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glcstctr](
	[company] [char](2) NOT NULL,
	[cscode] [char](4) NOT NULL,
	[csname] [varchar](30) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[modified] [bit] NOT NULL,
	[cslname] [varchar](30) NOT NULL,
	[whtype] [tinyint] NULL,
	[cs_code] [char](6) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[xpercent] [numeric](6, 3) NULL,
 CONSTRAINT [PK_glcstctr] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[cscode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[glcurr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glcurr](
	[curname] [varchar](30) NOT NULL,
	[curcode] [char](3) NOT NULL,
	[currate] [numeric](10, 5) NOT NULL,
	[curfix] [numeric](10, 5) NOT NULL,
	[cursname] [char](5) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[curparts] [char](10) NOT NULL,
	[modified] [bit] NOT NULL,
	[curlname] [varchar](30) NOT NULL,
	[curlsname] [char](10) NOT NULL,
	[curlparts] [char](10) NOT NULL,
	[curminrate] [numeric](12, 5) NULL,
	[curmaxrate] [numeric](12, 5) NULL,
	[standard_fcy_code] [varchar](3) NULL,
 CONSTRAINT [PK_glcurr] PRIMARY KEY CLUSTERED 
(
	[curcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gljrcost]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gljrcost](
	[company] [char](2) NOT NULL,
	[jdtype] [char](2) NOT NULL,
	[jdref] [numeric](6, 0) NOT NULL,
	[cstcode] [char](4) NOT NULL,
	[jdkey] [char](19) NOT NULL,
	[jdcurr] [char](3) NOT NULL,
	[Xpercent] [numeric](5, 2) NOT NULL,
	[amt] [float] NULL,
	[jddbcr] [char](1) NOT NULL,
	[jdfc_imgval] [float] NOT NULL,
	[jdfolno] [numeric](3, 0) NOT NULL,
	[rplct_post] [bit] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gljrdtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gljrdtl](
	[jdcomp] [char](2) NOT NULL,
	[jdtype] [char](2) NOT NULL,
	[jdref] [numeric](6, 0) NOT NULL,
	[jdkey] [char](19) NOT NULL,
	[jddate] [char](8) NOT NULL,
	[jdtext] [varchar](110) NOT NULL,
	[jdlcamt] [float] NOT NULL,
	[jddbcr] [char](1) NOT NULL,
	[jdfcamt] [float] NOT NULL,
	[jdcurr] [char](3) NOT NULL,
	[jdfolio] [numeric](4, 0) NOT NULL,
	[jdfolno] [numeric](3, 0) NOT NULL,
	[jdsysdate] [char](8) NOT NULL,
	[jdsrc] [char](2) NOT NULL,
	[jdfc_imgval] [float] NULL,
	[jdcstval] [float] NULL,
	[cstkey] [char](22) NULL,
	[brnno] [char](2) NULL,
	[bracc] [char](19) NULL,
	[brxref] [numeric](6, 0) NULL,
	[match] [bit] NULL,
	[rplct_post] [bit] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[taxcatId] [numeric](3, 0) NULL,
	[jhcustno] [char](6) NULL,
 CONSTRAINT [PK_gljrdtl] PRIMARY KEY CLUSTERED 
(
	[jdcomp] ASC,
	[jdtype] ASC,
	[jdref] ASC,
	[jdfolio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[gljrhdr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[gljrhdr](
	[jhcomp] [char](2) NOT NULL,
	[jhtype] [char](2) NOT NULL,
	[jhref] [numeric](6, 0) NOT NULL,
	[jhdate] [char](8) NOT NULL,
	[jhtext] [varchar](110) NOT NULL,
	[jhamt] [float] NOT NULL,
	[jhentries] [numeric](4, 0) NULL,
	[jhsrc] [char](2) NOT NULL,
	[jhsysdate] [char](8) NOT NULL,
	[jhcurr] [char](3) NOT NULL,
	[jhfcflag] [numeric](1, 0) NOT NULL,
	[jhrate] [float] NULL,
	[jhreleased] [bit] NOT NULL,
	[jhposted] [bit] NOT NULL,
	[lastupdt] [char](8) NULL,
	[jhlccrttl] [float] NULL,
	[jhlcdbttl] [float] NULL,
	[jhfccrttl] [float] NULL,
	[jhfcdbttl] [float] NULL,
	[jhimgrate] [float] NULL,
	[modified] [bit] NULL,
	[serial_no] [numeric](4, 0) NULL,
	[rcvdtrn] [bit] NULL,
	[suspend] [bit] NOT NULL,
	[usrid] [char](10) NOT NULL,
	[isbrtrx] [bit] NULL,
	[brxref] [char](8) NULL,
	[brxfrm] [char](2) NULL,
	[jhcustno] [char](6) NULL,
	[hide_jv] [bit] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[bankref] [char](20) NULL,
	[Vat_Percent] [numeric](5, 2) NULL,
	[jhtext1] [varchar](70) NULL,
	[sc_codeyrtp] [char](9) NULL,
	[zatca_rounding] [bit] NULL,
 CONSTRAINT [PK_gljrhdr] PRIMARY KEY CLUSTERED 
(
	[jhcomp] ASC,
	[jhtype] ASC,
	[jhref] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[glsction]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[glsction](
	[sc_code] [char](6) NULL,
	[sc_name] [varchar](40) NOT NULL,
	[sc_lname] [varchar](40) NOT NULL,
	[sc_company] [char](2) NOT NULL,
	[sc_whno] [char](2) NULL,
	[sc_arcode] [numeric](6, 0) NULL,
	[sc_nowh] [numeric](1, 0) NULL,
	[sc_m_center] [bit] NULL,
	[lastupdt] [char](8) NULL,
	[rebate_act] [char](19) NULL,
	[lossRebateAct] [char](19) NULL,
	[jv_01] [numeric](6, 0) NULL,
	[jv_02] [numeric](6, 0) NULL,
	[jv_03] [numeric](6, 0) NULL,
	[jv_04] [numeric](6, 0) NULL,
	[jv_05] [numeric](6, 0) NULL,
	[jv_06] [numeric](6, 0) NULL,
	[jv_07] [numeric](6, 0) NULL,
	[jv_08] [numeric](6, 0) NULL,
	[jv_09] [numeric](6, 0) NULL,
	[jv_10] [numeric](6, 0) NULL,
	[jv_11] [numeric](6, 0) NULL,
	[jv_12] [numeric](6, 0) NULL,
	[jv_13] [numeric](6, 0) NULL,
	[jv_14] [numeric](6, 0) NULL,
	[jv_18] [numeric](6, 0) NULL,
	[jv_19] [numeric](6, 0) NULL,
	[jv_20] [numeric](6, 0) NULL,
	[jv_21] [numeric](6, 0) NULL,
	[jv_22] [numeric](6, 0) NULL,
	[jv_23] [numeric](6, 0) NULL,
	[jv_24] [numeric](6, 0) NULL,
	[jv_26] [numeric](6, 0) NULL,
	[jv_27] [numeric](6, 0) NULL,
	[jv_28] [numeric](6, 0) NULL,
	[jv_30] [numeric](6, 0) NULL,
	[jv_31] [numeric](6, 0) NULL,
	[jv_32] [numeric](6, 0) NULL,
	[jv_33] [numeric](6, 0) NULL,
	[jv_34] [numeric](6, 0) NULL,
	[jv_45] [numeric](10, 0) NULL,
	[jv_46] [numeric](6, 0) NULL,
	[jv_16] [numeric](6, 0) NULL,
	[jv_17] [numeric](6, 0) NULL,
	[sysno] [numeric](2, 0) NULL,
	[No_round_nm] [bit] NULL,
	[PriceVatType] [numeric](1, 0) NULL,
	[mkt_frc_rounding] [bit] NULL,
	[is_dsc_amt] [bit] NULL,
	[auto_dsc_hll] [bit] NULL,
	[max_dsc_hll] [numeric](3, 2) NULL,
	[sc_card_srlno] [int] NULL,
	[sc_card_jvno] [int] NULL,
	[ar_dscser] [char](19) NULL,
	[ap_dscser] [char](19) NULL,
	[sc_lvlno] [int] NULL,
	[cashser] [char](19) NULL,
	[crdt_limit] [float] NULL,
	[sc_lvl1] [char](2) NULL,
	[sc_lvl2] [char](2) NULL,
	[sc_lvl3] [char](2) NULL,
	[CHKEY] [int] NULL,
	[PKEY] [int] NULL,
	[jv_start_year_serial] [numeric](6, 0) NULL,
	[sc_fxdpart] [char](2) NULL,
	[jv_301] [int] NULL,
	[jv_60] [int] NULL,
	[jv_61] [int] NULL,
	[jv_105] [int] NULL,
	[jv_106] [int] NULL,
	[jv_107] [int] NULL,
	[jv_108] [int] NULL,
	[jv_109] [int] NULL,
	[jv_110] [int] NULL,
	[jv_205] [int] NULL,
	[jv_209] [int] NULL,
	[jv_210] [int] NULL,
	[jv_211] [int] NULL,
	[jv_212] [int] NULL,
	[jv_213] [int] NULL,
	[jv_214] [int] NULL,
	[jv_215] [int] NULL,
	[jv_216] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jccstord_dtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jccstord_dtl](
	[company] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NULL,
	[itemno] [char](16) NULL,
	[unicode] [char](6) NULL,
	[qty] [numeric](13, 3) NULL,
	[custno] [char](6) NULL,
	[fcy] [char](3) NULL,
	[barcode] [char](20) NULL,
	[cmbkey] [char](24) NULL,
	[jcno] [numeric](10, 0) NULL,
	[folio] [numeric](7, 0) NOT NULL,
 CONSTRAINT [PK_jccstord_dtl] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[refno] ASC,
	[folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jccstord_hdr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jccstord_hdr](
	[company] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NULL,
	[custno] [char](6) NOT NULL,
	[custnm] [varchar](50) NULL,
	[fcy] [char](3) NOT NULL,
	[fcyrate] [numeric](6, 3) NULL,
	[entries] [numeric](5, 0) NULL,
	[cstordrno] [char](10) NULL,
	[orddatetime] [smalldatetime] NULL,
	[lastupdt] [char](8) NULL,
	[modified] [bit] NULL,
	[rcvdtrn] [bit] NULL,
	[slcode] [char](2) NULL,
 CONSTRAINT [PK_jccstord_hdr] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jchdr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jchdr](
	[ch_company] [char](2) NOT NULL,
	[ch_jcno] [numeric](10, 0) NOT NULL,
	[ch_jcdate] [char](8) NOT NULL,
	[ch_jcdesc] [varchar](70) NOT NULL,
	[cmbkey] [char](24) NOT NULL,
	[ch_cucode] [char](6) NOT NULL,
	[ch_price] [numeric](12, 3) NOT NULL,
	[ch_batchqty] [numeric](12, 3) NOT NULL,
	[ch_tgtqty] [float] NULL,
	[ch_ttlcost] [float] NOT NULL,
	[ch_matitems] [numeric](5, 0) NOT NULL,
	[ch_expentries] [numeric](5, 0) NOT NULL,
	[ch_matttlqty] [float] NULL,
	[ch_expttlhours] [float] NOT NULL,
	[ch_expttlcost] [float] NOT NULL,
	[ch_matttlcost] [float] NOT NULL,
	[ch_fnlqty] [float] NULL,
	[ch_stg1waste] [float] NULL,
	[ch_stg2waste] [float] NULL,
	[ch_stg3waste] [float] NULL,
	[ch_othrwaste] [float] NULL,
	[ch_ttlwaste] [float] NULL,
	[ch_untcost] [float] NOT NULL,
	[ch_status] [char](1) NOT NULL,
	[ch_sampleno] [char](10) NOT NULL,
	[ch_xfrno] [numeric](6, 0) NOT NULL,
	[ch_issno] [numeric](6, 0) NOT NULL,
	[ch_rcvno] [numeric](6, 0) NOT NULL,
	[ch_rcvdate] [char](8) NOT NULL,
	[ch_dpcmbkey] [char](24) NOT NULL,
	[usrid] [char](10) NOT NULL,
	[modified] [bit] NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[ch_expentries1] [numeric](5, 0) NULL,
	[ch_expttlhours1] [float] NULL,
	[ch_expttlcost1] [float] NULL,
	[ch_expentries2] [numeric](5, 0) NULL,
	[ch_expttlhours2] [float] NULL,
	[ch_expttlcost2] [float] NULL,
	[ch_expentries3] [numeric](5, 0) NULL,
	[ch_expttlhours3] [float] NULL,
	[ch_expttlcost3] [float] NULL,
	[ch_xfr_gnrtdt] [smalldatetime] NULL,
	[ch_xfr_postdt] [smalldatetime] NULL,
	[ch_iss_gnrtdt] [smalldatetime] NULL,
	[ch_iss_postdt] [smalldatetime] NULL,
	[ch_rcv_gnrtdt] [smalldatetime] NULL,
	[ch_rcv_postdt] [smalldatetime] NULL,
	[ch_fnlqtyrcv] [float] NULL,
	[ch_cstrqstno] [numeric](6, 0) NULL,
	[fcy] [char](3) NULL,
	[fcyrate] [float] NULL,
	[ch_ttlcost_fcy] [float] NULL,
	[ch_expttlcost_fcy] [float] NULL,
	[ch_matttlcost_fcy] [float] NULL,
	[ch_untcost_fcy] [float] NULL,
	[ch_expttlcost1_fcy] [float] NULL,
	[ch_expttlcost2_fcy] [float] NULL,
	[ch_expttlcost3_fcy] [float] NULL,
	[section] [char](4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jcitmwclass]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jcitmwclass](
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[ws_code] [char](4) NOT NULL,
	[ws_fmqty] [numeric](12, 3) NOT NULL,
	[ws_toqty] [numeric](12, 3) NOT NULL,
	[ws_wastepctg] [float] NOT NULL,
	[cmbkey] [char](24) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jcmatdtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jcmatdtl](
	[cd_company] [char](2) NOT NULL,
	[cd_jcno] [numeric](10, 0) NOT NULL,
	[cmbkey] [char](24) NOT NULL,
	[tgtqty] [float] NULL,
	[wastepctg] [float] NOT NULL,
	[qtyb4waste] [float] NULL,
	[fnlqty] [float] NULL,
	[lcost] [float] NOT NULL,
	[folio] [numeric](5, 0) NOT NULL,
	[fcost] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jcresources]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jcresources](
	[rs_code] [char](4) NOT NULL,
	[rs_desc] [char](30) NOT NULL,
	[rs_ldesc] [char](30) NOT NULL,
	[rs_type] [numeric](1, 0) NOT NULL,
	[rs_hourcost] [float] NOT NULL,
	[rs_remarks] [char](30) NOT NULL,
	[modified] [bit] NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[rs_level] [numeric](1, 0) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jcrsrsdtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jcrsrsdtl](
	[rd_company] [char](2) NOT NULL,
	[rd_jcno] [numeric](10, 0) NOT NULL,
	[rd_code] [char](4) NOT NULL,
	[rd_tgthours] [float] NOT NULL,
	[rd_hourcost] [float] NOT NULL,
	[rd_remarks] [char](30) NOT NULL,
	[rd_fnlhours] [float] NOT NULL,
	[folio] [numeric](5, 0) NOT NULL,
	[rd_hourcost_fcy] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jcsetup]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jcsetup](
	[mscomp] [char](2) NULL,
	[jc_whrcycle] [char](2) NULL,
	[jc_whfactory] [char](2) NULL,
	[jc_whready] [char](2) NULL,
	[jc_whrow] [char](2) NULL,
	[jc_itemhalik] [char](24) NULL,
	[jc_addmatitm] [bit] NULL,
	[jc_chgmatqty] [bit] NULL,
	[jc_chgwsptg] [bit] NULL,
	[jc_usefnlwste] [bit] NULL,
	[jc_seplocprdday] [bit] NULL,
	[jc_resources_cost_is_fcy] [bit] NULL,
	[brnno] [char](2) NULL,
	[sc_code] [char](4) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jcstditmmat]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jcstditmmat](
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[rsitemno] [char](16) NOT NULL,
	[rsunicode] [char](6) NOT NULL,
	[tgtqty] [float] NULL,
	[wastepctg] [float] NOT NULL,
	[qtyb4waste] [float] NULL,
	[cmbkey] [char](24) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jcstditmrsrc]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jcstditmrsrc](
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[rs_code] [char](4) NOT NULL,
	[rs_hours] [float] NOT NULL,
	[rs_remarks] [char](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[jcstitems]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[jcstitems](
	[cmbkey] [char](24) NOT NULL,
	[is_mnfctrd] [bit] NULL,
	[rs_type] [numeric](1, 0) NULL,
	[is_material] [bit] NULL,
	[unt_weight] [numeric](14, 3) NULL,
	[is_batch] [bit] NULL,
	[itm_batch_qty] [numeric](14, 3) NULL,
	[days_to_exp_fm_prod] [int] NULL,
 CONSTRAINT [PK_jcstitems] PRIMARY KEY CLUSTERED 
(
	[cmbkey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ord_dtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ord_dtl](
	[company] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[qty] [float] NULL,
	[price] [float] NULL,
	[discpc] [numeric](5, 2) NOT NULL,
	[cost] [numeric](11, 2) NOT NULL,
	[custno] [char](6) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[barcode] [char](20) NOT NULL,
	[pack] [char](1) NOT NULL,
	[pkqty] [numeric](10, 3) NULL,
	[qtyrcv] [float] NULL,
	[qtyrsv] [float] NULL,
	[lstrcvdate] [char](8) NOT NULL,
	[cmbkey] [char](24) NULL,
	[fqty] [numeric](12, 2) NULL,
	[folio] [int] NULL,
	[splyinv] [varchar](20) NULL,
	[dlvrydate] [char](8) NULL,
	[caser] [char](19) NULL,
	[brqty3] [numeric](12, 3) NULL,
	[brqty4] [numeric](12, 3) NULL,
	[shadd] [char](1) NULL,
	[shdpk] [numeric](10, 3) NULL,
	[shdqty] [numeric](9, 3) NULL,
	[frtqty] [numeric](9, 3) NULL,
	[Taxtype] [char](1) NULL,
	[remarks] [varchar](40) NULL,
	[item_bal] [numeric](13, 3) NULL,
	[mnpack0] [char](1) NULL,
	[last_ord_cost] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ord_hdr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ord_hdr](
	[branch] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[custno] [char](6) NOT NULL,
	[custnm] [varchar](50) NOT NULL,
	[glser] [char](19) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[fcyrate] [numeric](6, 3) NOT NULL,
	[invttl] [float] NOT NULL,
	[invcst] [float] NOT NULL,
	[invdspc] [float] NOT NULL,
	[invdsvl] [float] NOT NULL,
	[valafds] [float] NOT NULL,
	[invpaid] [float] NOT NULL,
	[caser] [char](19) NOT NULL,
	[entries] [numeric](5, 0) NOT NULL,
	[fixrate] [numeric](6, 3) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[isl_c] [bit] NOT NULL,
	[modified] [bit] NOT NULL,
	[splyinv] [varchar](20) NULL,
	[closed] [bit] NOT NULL,
	[processed] [bit] NOT NULL,
	[rcvdtrn] [bit] NOT NULL,
	[usrid] [char](10) NULL,
	[vat_amt_paid] [float] NULL,
	[PriceIncludeVat] [bit] NULL,
	[taxfree_purchase] [float] NULL,
	[fqtyval] [float] NULL,
	[dlvry_date] [char](8) NULL,
	[tdscpcs] [numeric](5, 2) NULL,
	[tdscdays] [numeric](3, 0) NULL,
	[slcenter] [char](2) NULL,
	[slcode] [char](2) NULL,
 CONSTRAINT [PK_ord_hdr] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orpacking]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orpacking](
	[pack_id] [char](1) NOT NULL,
	[pkname] [varchar](30) NULL,
	[lpkname] [char](15) NOT NULL,
	[pkorder] [char](1) NOT NULL,
	[pkdfqty] [numeric](8, 3) NULL,
	[pkwhlsl] [bit] NULL,
	[standard_unit_code] [varchar](5) NULL,
 CONSTRAINT [PK_orpacking] PRIMARY KEY CLUSTERED 
(
	[pack_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pudept]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pudept](
	[dp_name] [varchar](30) NOT NULL,
	[dp_brno] [char](2) NOT NULL,
	[dp_dept] [char](2) NOT NULL,
	[dp_cashser] [char](19) NOT NULL,
	[dp_cslser] [char](19) NOT NULL,
	[dp_oslser] [char](19) NOT NULL,
	[dp_rcslser] [char](19) NOT NULL,
	[dp_roslser] [char](19) NOT NULL,
	[dp_custser] [char](19) NOT NULL,
	[dp_expser] [char](19) NOT NULL,
	[dp_okdiff] [bit] NOT NULL,
	[dp_diffser] [char](19) NOT NULL,
	[dp_mainwh] [char](2) NOT NULL,
	[dp_rtrnwh] [char](2) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[dp_comp] [char](2) NOT NULL,
	[modified] [bit] NOT NULL,
	[cstcode] [char](4) NOT NULL,
	[serfrt] [char](19) NOT NULL,
	[serins] [char](19) NOT NULL,
	[sercst] [char](19) NOT NULL,
	[serpvl] [char](19) NOT NULL,
	[sersmp] [char](19) NOT NULL,
	[serfn] [char](19) NOT NULL,
	[sertkt] [char](19) NOT NULL,
	[serfre] [char](19) NOT NULL,
	[sertrn] [char](19) NOT NULL,
	[seroth] [char](19) NOT NULL,
	[dp_lname] [varchar](30) NOT NULL,
	[vat_paid_act] [char](19) NULL,
	[chk_serfrt] [bit] NULL,
	[chk_serins] [bit] NULL,
	[chk_sercst] [bit] NULL,
	[chk_serpvl] [bit] NULL,
	[chk_sersmp] [bit] NULL,
	[chk_serfn] [bit] NULL,
	[chk_sertkt] [bit] NULL,
	[chk_serfre] [bit] NULL,
	[chk_sertrn] [bit] NULL,
	[chk_seroth] [bit] NULL,
	[VAT_AUTO_CALC] [bit] NULL,
	[suspended] [bit] NULL,
	[sc_code] [char](6) NULL,
	[servndr] [char](19) NULL,
 CONSTRAINT [PK_pudept] PRIMARY KEY CLUSTERED 
(
	[dp_brno] ASC,
	[dp_dept] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[pudtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pudtl](
	[slcenter] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[qty] [float] NULL,
	[fqty] [numeric](10, 3) NOT NULL,
	[price] [float] NULL,
	[discpc] [float] NULL,
	[cost] [numeric](11, 2) NOT NULL,
	[ds_acfm] [numeric](1, 0) NOT NULL,
	[sl_acfm] [numeric](1, 0) NOT NULL,
	[gclass] [char](12) NOT NULL,
	[custno] [char](6) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[barcode] [char](20) NOT NULL,
	[imfcval] [float] NOT NULL,
	[pack] [char](1) NOT NULL,
	[pkqty] [numeric](10, 3) NULL,
	[expdate] [char](8) NOT NULL,
	[binno] [char](6) NOT NULL,
	[shdqty] [numeric](9, 3) NOT NULL,
	[shdpk] [numeric](10, 3) NULL,
	[shadd] [char](1) NOT NULL,
	[frtqty] [numeric](9, 3) NOT NULL,
	[cmbkey] [char](24) NULL,
	[folio] [numeric](7, 0) NOT NULL,
	[rplct_post] [bit] NULL,
	[whno] [char](2) NULL,
	[splyinv] [char](20) NULL,
	[edm_value] [numeric](10, 3) NULL,
	[garntee_amt] [float] NULL,
	[Taxtype] [char](1) NULL,
	[item_vat] [numeric](12, 3) NULL,
	[item_price_net] [float] NULL,
	[item_fq_vat] [numeric](12, 3) NULL,
	[invdscamt] [float] NULL,
	[dsc_amt] [float] NULL,
 CONSTRAINT [PK_pudtl] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[invtype] ASC,
	[refno] ASC,
	[folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[puhdr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[puhdr](
	[slcenter] [char](2) NOT NULL,
	[branch] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[custno] [char](6) NOT NULL,
	[custnm] [varchar](50) NOT NULL,
	[glser] [char](19) NOT NULL,
	[dsctype] [char](1) NOT NULL,
	[pstmode] [numeric](1, 0) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[fcyrate] [float] NULL,
	[duedate] [char](8) NOT NULL,
	[invttl] [float] NOT NULL,
	[invcst] [float] NOT NULL,
	[invdspc] [float] NOT NULL,
	[invdsvl] [float] NOT NULL,
	[valafds] [float] NOT NULL,
	[invpaid] [float] NOT NULL,
	[caser] [char](19) NOT NULL,
	[entries] [numeric](5, 0) NOT NULL,
	[released] [bit] NOT NULL,
	[posted] [bit] NOT NULL,
	[fixrate] [float] NULL,
	[spply_exp] [float] NOT NULL,
	[pricetp] [char](1) NOT NULL,
	[isglact] [bit] NOT NULL,
	[chkno] [char](8) NOT NULL,
	[chkdate] [char](8) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[jvgenrt] [bit] NOT NULL,
	[imfcval] [float] NOT NULL,
	[lcser] [char](19) NOT NULL,
	[frieght] [numeric](12, 2) NOT NULL,
	[insurexp] [numeric](12, 2) NOT NULL,
	[customfee] [numeric](12, 2) NOT NULL,
	[portexp] [numeric](12, 2) NOT NULL,
	[samplexp] [numeric](12, 2) NOT NULL,
	[lcinvexp] [float] NOT NULL,
	[fcinvexp] [float] NOT NULL,
	[lcothrexp] [numeric](12, 2) NOT NULL,
	[fineexp] [numeric](12, 2) NOT NULL,
	[lcttlexp] [float] NOT NULL,
	[fcttlexp] [float] NOT NULL,
	[tktexp] [numeric](11, 2) NOT NULL,
	[freexp] [numeric](11, 2) NOT NULL,
	[transexp] [numeric](11, 2) NOT NULL,
	[prodrate] [float] NOT NULL,
	[isl_c] [bit] NOT NULL,
	[binno] [char](6) NOT NULL,
	[aprxcst] [bit] NOT NULL,
	[aprxpc] [float] NOT NULL,
	[aprxser] [char](19) NOT NULL,
	[expser] [char](19) NOT NULL,
	[modified] [bit] NOT NULL,
	[splyinv] [char](20) NULL,
	[isorder] [bit] NOT NULL,
	[settled] [bit] NOT NULL,
	[rcvdtrn] [bit] NOT NULL,
	[fcothrexp] [numeric](12, 2) NOT NULL,
	[usrid] [char](10) NOT NULL,
	[jvdsc] [numeric](6, 0) NOT NULL,
	[paylcl] [bit] NOT NULL,
	[tdscpcs] [numeric](5, 2) NOT NULL,
	[tdscdays] [numeric](3, 0) NULL,
	[orderno] [char](20) NOT NULL,
	[slcode] [char](2) NOT NULL,
	[lccode] [char](15) NULL,
	[shpdate] [char](8) NULL,
	[edm] [int] NULL,
	[gntd_fm_lc] [bit] NULL,
	[lc_ship_no] [numeric](4, 0) NULL,
	[xfr_amt] [float] NULL,
	[xfr_acc] [char](19) NULL,
	[vat_amt_paid] [float] NULL,
	[taxfree_purchase] [float] NULL,
	[VatNot4Vender] [bit] NULL,
	[vndr_taxcode] [varchar](20) NULL,
	[expns4vat] [float] NULL,
	[tax_Pd_mthd] [char](1) NULL,
	[vndr_kind] [char](1) NULL,
	[manulvat] [float] NULL,
	[dscamt_type] [numeric](1, 0) NULL,
	[hlldscnt] [float] NULL,
	[PriceIncludeVat] [bit] NULL,
	[vat_percent] [numeric](5, 2) NULL,
	[fqtyval] [float] NULL,
	[datetime_stamp] [datetime] NULL,
	[chng_item_price] [bit] NULL,
	[zatca_rounding] [bit] NULL,
	[unincld_vndr_expns] [float] NULL,
	[is_pu_dsc_amt] [bit] NULL,
 CONSTRAINT [PK_puhdr] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[invtype] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[salecntr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[salecntr](
	[dp_name] [varchar](30) NOT NULL,
	[dp_brno] [char](2) NOT NULL,
	[dp_dept] [char](2) NOT NULL,
	[dp_cashser] [char](19) NOT NULL,
	[dp_cslser] [char](19) NOT NULL,
	[dp_oslser] [char](19) NOT NULL,
	[dp_rcslser] [char](19) NOT NULL,
	[dp_roslser] [char](19) NOT NULL,
	[dp_custser] [char](19) NOT NULL,
	[dp_expser] [char](19) NOT NULL,
	[dp_okdiff] [bit] NOT NULL,
	[dp_diffser] [char](19) NOT NULL,
	[dp_mainwh] [char](2) NOT NULL,
	[dp_rtrnwh] [char](2) NOT NULL,
	[lastupdt] [char](10) NOT NULL,
	[dp_comp] [char](2) NOT NULL,
	[dp_fccrdt] [bit] NOT NULL,
	[nochg_print] [bit] NOT NULL,
	[modified] [bit] NOT NULL,
	[srcst] [char](19) NOT NULL,
	[cstcode] [char](4) NOT NULL,
	[dp_crdcardac] [char](19) NOT NULL,
	[dp_rplsac] [char](19) NOT NULL,
	[dp_cardcomm] [char](19) NOT NULL,
	[dp_lname] [varchar](30) NOT NULL,
	[slwhsrc] [numeric](1, 0) NULL,
	[prpaidcrdac] [char](19) NOT NULL,
	[FRC_CRSL_FC] [bit] NULL,
	[inv_form_no] [numeric](2, 0) NULL,
	[sc_code] [char](6) NULL,
	[sanedcrd_act] [char](19) NULL,
	[no_of_invCopies] [numeric](1, 0) NULL,
	[vat_rcvd_act] [char](19) NULL,
	[custody_ac] [char](19) NULL,
	[stcpay_act] [char](19) NULL,
	[suspended] [bit] NULL,
	[qitaf_act] [char](19) NULL,
	[slscmnact] [char](19) NULL,
	[webcmnact] [char](19) NULL,
	[tprtexpact] [char](19) NULL,
	[bldg_no] [varchar](50) NULL,
	[bldg_no_l] [varchar](50) NULL,
	[street_name] [varchar](50) NULL,
	[street_name_l] [varchar](50) NULL,
	[area_name] [varchar](50) NULL,
	[area_name_l] [varchar](50) NULL,
	[extra_address_no] [varchar](50) NULL,
	[extra_address_no_l] [varchar](50) NULL,
	[district] [varchar](50) NULL,
	[district_l] [varchar](50) NULL,
	[city_text] [varchar](50) NULL,
	[city_text_l] [varchar](50) NULL,
	[street_name2] [varchar](50) NULL,
	[street_name2_l] [varchar](50) NULL,
	[postal_code] [varchar](20) NULL,
	[Other_id_SchemeID] [varchar](20) NULL,
	[Group_VAT_ID] [varchar](30) NULL,
	[country_code] [int] NULL,
	[Other_Scheme_Type] [varchar](10) NULL,
	[manafith_api] [varchar](100) NULL,
 CONSTRAINT [PK_salecntr] PRIMARY KEY CLUSTERED 
(
	[dp_brno] ASC,
	[dp_dept] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_dd]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_dd](
	[slcenter] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[qty] [float] NULL,
	[fqty] [numeric](11, 3) NOT NULL,
	[price] [float] NULL,
	[discpc] [float] NULL,
	[cost] [float] NOT NULL,
	[ds_acfm] [numeric](1, 0) NOT NULL,
	[sl_acfm] [numeric](1, 0) NOT NULL,
	[gclass] [char](12) NOT NULL,
	[custno] [char](6) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[barcode] [char](20) NOT NULL,
	[imfcval] [float] NOT NULL,
	[pack] [char](1) NOT NULL,
	[pkqty] [numeric](8, 3) NOT NULL,
	[shadd] [char](1) NOT NULL,
	[shdpk] [numeric](8, 3) NOT NULL,
	[shdqty] [numeric](11, 3) NOT NULL,
	[frtqty] [numeric](9, 3) NOT NULL,
	[rtnqty] [numeric](12, 3) NOT NULL,
	[whno] [char](2) NOT NULL,
	[cmbkey] [char](24) NULL,
	[dscqty] [numeric](12, 3) NULL,
	[dscprice] [float] NULL,
	[rplct_post] [bit] NULL,
	[folio] [numeric](4, 0) NOT NULL,
	[whqty] [varchar](200) NULL,
	[nprice2] [numeric](12, 3) NULL,
	[nprice3] [numeric](12, 3) NULL,
	[jvtype] [char](2) NULL,
	[jvref] [numeric](6, 0) NULL,
	[taxtype] [char](1) NULL,
	[item_vat] [numeric](12, 3) NULL,
	[item_price_net] [float] NULL,
	[dscpack] [char](1) NULL,
	[avgcost] [float] NULL,
 CONSTRAINT [PK_sales_dd] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[invtype] ASC,
	[refno] ASC,
	[folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_dh]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_dh](
	[slcenter] [char](2) NOT NULL,
	[branch] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[custno] [char](6) NOT NULL,
	[custnm] [varchar](50) NOT NULL,
	[glser] [char](19) NOT NULL,
	[dsctype] [char](1) NOT NULL,
	[pstmode] [numeric](1, 0) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[fcyrate] [numeric](6, 3) NOT NULL,
	[duedate] [char](8) NOT NULL,
	[invttl] [float] NOT NULL,
	[invcst] [float] NOT NULL,
	[invdspc] [float] NOT NULL,
	[invdsvl] [float] NOT NULL,
	[valafds] [float] NOT NULL,
	[invpaid] [numeric](14, 2) NOT NULL,
	[caser] [char](19) NOT NULL,
	[entries] [numeric](5, 0) NOT NULL,
	[released] [bit] NOT NULL,
	[posted] [bit] NOT NULL,
	[fixrate] [numeric](6, 3) NOT NULL,
	[extamt] [numeric](14, 2) NOT NULL,
	[extser] [char](19) NOT NULL,
	[pricetp] [char](1) NOT NULL,
	[ischeque] [bit] NOT NULL,
	[chkno] [char](8) NOT NULL,
	[chkdate] [char](8) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[jvgenrt] [bit] NOT NULL,
	[cccommsn] [float] NOT NULL,
	[belowbal] [bit] NOT NULL,
	[fcy2] [char](3) NOT NULL,
	[ccpayment] [numeric](13, 2) NOT NULL,
	[rplsamt] [numeric](13, 2) NOT NULL,
	[pdother] [bit] NOT NULL,
	[slcode] [char](2) NOT NULL,
	[prpaidamt] [numeric](12, 2) NULL,
	[instldays] [numeric](2, 0) NOT NULL,
	[instflag] [bit] NOT NULL,
	[slcmnd] [bit] NOT NULL,
	[inv_printed] [numeric](2, 0) NOT NULL,
	[bendit] [bit] NOT NULL,
	[modified] [bit] NOT NULL,
	[rqstorder] [numeric](6, 0) NOT NULL,
	[rqststld] [bit] NOT NULL,
	[carrier] [char](3) NOT NULL,
	[rcvdtrn] [bit] NOT NULL,
	[usrid] [char](10) NOT NULL,
	[address] [varchar](50) NOT NULL,
	[suspend] [bit] NOT NULL,
	[rtnref] [numeric](6, 0) NOT NULL,
	[ispurchase] [bit] NOT NULL,
	[stkjvno] [numeric](6, 0) NOT NULL,
	[posinv] [numeric](1, 0) NULL,
	[jvdate] [char](8) NULL,
	[vat_amt_rcvd] [float] NULL,
	[taxfree_sales] [float] NULL,
	[PriceVatType] [numeric](1, 0) NULL,
	[vat_percent] [numeric](5, 2) NULL,
	[datetime_stamp] [datetime] NULL,
	[clnt_taxcode] [varchar](20) NULL,
	[clnt_kind] [char](1) NULL,
	[jvtype] [char](2) NULL,
	[jvref] [numeric](6, 0) NULL,
	[yrcode] [char](4) NULL,
	[zatca_rounding] [bit] NULL,
	[dsc4allqty] [bit] NULL,
	[invoicelist] [varchar](200) NULL,
 CONSTRAINT [PK_sales_dh] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[invtype] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_dt]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_dt](
	[slcenter] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[qty] [float] NULL,
	[fqty] [numeric](11, 3) NOT NULL,
	[price] [float] NULL,
	[discpc] [float] NOT NULL,
	[cost] [float] NOT NULL,
	[ds_acfm] [numeric](1, 0) NOT NULL,
	[sl_acfm] [numeric](1, 0) NOT NULL,
	[gclass] [char](12) NOT NULL,
	[custno] [char](6) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[barcode] [char](20) NOT NULL,
	[imfcval] [float] NOT NULL,
	[pack] [char](1) NOT NULL,
	[pkqty] [numeric](10, 3) NULL,
	[shadd] [char](1) NOT NULL,
	[shdpk] [numeric](10, 3) NULL,
	[shdqty] [numeric](11, 3) NOT NULL,
	[frtqty] [numeric](9, 3) NOT NULL,
	[rtnqty] [float] NULL,
	[whno] [char](2) NOT NULL,
	[cmbkey] [char](24) NULL,
	[folio] [numeric](7, 0) NOT NULL,
	[rplct_post] [bit] NULL,
	[sold_item_status] [numeric](1, 0) NULL,
	[Taxtype] [char](1) NULL,
	[ps_item_vat] [float] NULL,
	[dsc_amt] [float] NULL,
	[binno] [char](6) NULL,
	[item_price_net] [float] NULL,
	[invdscamt] [float] NULL,
	[item_fq_vat] [numeric](13, 3) NULL,
	[item_vat] [numeric](14, 3) NULL,
	[m_sl_ref] [int] NULL,
 CONSTRAINT [PK_sales_dt] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[invtype] ASC,
	[refno] ASC,
	[folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_ei]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_ei](
	[company] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[InvoiceTypeCode] [varchar](6) NULL,
	[tax_invoice_type] [char](2) NULL,
	[uuid] [uniqueidentifier] ROWGUIDCOL  NULL,
	[previousInvoiceHash] [text] NULL,
	[QRvalue] [text] NULL,
	[Order_ref_id] [varchar](50) NULL,
	[ContractDocRef] [varchar](50) NULL,
	[PaymentType] [varchar](50) NULL,
	[InvoiceTransactionCode] [varchar](10) NULL,
	[DebitCreditReason] [varchar](100) NULL,
	[CurrentInvoiceHash] [text] NULL,
	[InvoiceCounterValue] [varchar](40) NULL,
	[LatestDeliveryDate] [date] NULL,
	[einv_is_sent] [int] NULL,
	[usr_slct_simple_einv] [bit] NULL,
	[invoice_charges] [float] NULL,
	[ubl] [varchar](max) NULL,
	[ExemptionReason] [varchar](100) NULL,
	[Exemptioncode] [varchar](20) NULL,
	[reason_not_sent] [varchar](2000) NULL,
	[zatca_datetime] [varchar](40) NULL,
	[folio] [varchar](20) NULL,
	[DeviceSN] [varchar](100) NULL,
	[is_production] [bit] NULL,
 CONSTRAINT [PK_sales_ei] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[invtype] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_gd]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_gd](
	[refno] [numeric](6, 0) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[company] [char](2) NOT NULL,
	[barcode] [char](20) NOT NULL,
	[cmbkey] [char](24) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_gh]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_gh](
	[refno] [numeric](6, 0) NOT NULL,
	[sysdate] [char](8) NOT NULL,
	[xdesc] [varchar](50) NOT NULL,
	[company] [char](2) NOT NULL,
	[entries] [numeric](5, 0) NOT NULL,
	[suspend] [bit] NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[modified] [bit] NOT NULL,
	[rcvdtrn] [bit] NOT NULL,
	[usrid] [char](10) NOT NULL,
 CONSTRAINT [PK_sales_gh_1] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_hd]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_hd](
	[slcenter] [char](2) NOT NULL,
	[branch] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[custno] [char](6) NOT NULL,
	[custnm] [varchar](50) NOT NULL,
	[glser] [char](19) NOT NULL,
	[dsctype] [char](1) NOT NULL,
	[pstmode] [numeric](1, 0) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[fcyrate] [numeric](6, 3) NOT NULL,
	[duedate] [char](8) NOT NULL,
	[invttl] [float] NOT NULL,
	[invcst] [float] NOT NULL,
	[invdspc] [float] NOT NULL,
	[invdsvl] [float] NOT NULL,
	[valafds] [float] NOT NULL,
	[invpaid] [float] NULL,
	[caser] [char](19) NOT NULL,
	[entries] [numeric](6, 0) NULL,
	[released] [bit] NOT NULL,
	[posted] [bit] NOT NULL,
	[fixrate] [numeric](6, 3) NOT NULL,
	[extamt] [float] NULL,
	[extser] [char](19) NOT NULL,
	[pricetp] [char](1) NOT NULL,
	[ischeque] [bit] NOT NULL,
	[chkno] [char](8) NOT NULL,
	[chkdate] [char](8) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[jvgenrt] [bit] NOT NULL,
	[cccommsn] [float] NOT NULL,
	[belowbal] [bit] NOT NULL,
	[fcy2] [char](3) NOT NULL,
	[ccpayment] [float] NULL,
	[rplsamt] [float] NULL,
	[pdother] [bit] NOT NULL,
	[slcode] [char](2) NOT NULL,
	[prpaidamt] [float] NULL,
	[instldays] [numeric](2, 0) NOT NULL,
	[instflag] [bit] NOT NULL,
	[slcmnd] [bit] NOT NULL,
	[inv_printed] [numeric](2, 0) NOT NULL,
	[bendit] [bit] NOT NULL,
	[modified] [bit] NOT NULL,
	[rqstorder] [numeric](6, 0) NOT NULL,
	[rqststld] [bit] NOT NULL,
	[carrier] [char](3) NOT NULL,
	[rcvdtrn] [bit] NOT NULL,
	[usrid] [char](10) NOT NULL,
	[address] [varchar](50) NOT NULL,
	[suspend] [bit] NOT NULL,
	[rtnref] [numeric](6, 0) NOT NULL,
	[ispurchase] [bit] NOT NULL,
	[stkjvno] [numeric](6, 0) NOT NULL,
	[posinv] [numeric](1, 0) NULL,
	[sanedcrd_amt] [numeric](12, 2) NULL,
	[remarks] [char](1) NULL,
	[remarks2] [char](40) NULL,
	[invlocked] [bit] NULL,
	[rtncash_dfrpl] [numeric](12, 2) NULL,
	[vat_amt_rcvd] [float] NULL,
	[taxfree_sales] [float] NULL,
	[clnt_taxcode] [varchar](20) NULL,
	[clnt_kind] [char](1) NULL,
	[hlldscnt] [float] NULL,
	[sysno] [numeric](2, 0) NULL,
	[No_round_nm] [bit] NULL,
	[PriceVatType] [numeric](1, 0) NULL,
	[smssent] [bit] NULL,
	[stcpay_amt] [float] NULL,
	[fc2lcamt] [float] NULL,
	[qitaf_amt] [float] NULL,
	[whlslinv] [bit] NULL,
	[vat_percent] [numeric](5, 2) NULL,
	[fsh_printed] [numeric](2, 0) NULL,
	[fqtyval] [float] NULL,
	[datetime_stamp] [datetime] NULL,
	[discountedBill] [bit] NULL,
	[Fusrprintinv] [varchar](10) NULL,
	[almnm_contract_section] [numeric](1, 0) NULL,
	[instlmnt_code] [numeric](3, 0) NULL,
	[installment_amt] [float] NULL,
	[mobileNo] [varchar](20) NULL,
	[client_name] [varchar](40) NULL,
	[cashpaid] [float] NULL,
	[zatca_rounding] [bit] NULL,
	[multi_refund_inv] [bit] NULL,
	[refund_no_inv_avl] [bit] NULL,
 CONSTRAINT [PK_sales_hd_1] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[invtype] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_od]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_od](
	[slcenter] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[qty] [float] NULL,
	[fqty] [numeric](10, 3) NOT NULL,
	[price] [float] NULL,
	[discpc] [numeric](6, 2) NOT NULL,
	[cost] [float] NOT NULL,
	[ds_acfm] [numeric](1, 0) NOT NULL,
	[sl_acfm] [numeric](1, 0) NOT NULL,
	[gclass] [char](8) NOT NULL,
	[custno] [char](6) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[barcode] [char](20) NOT NULL,
	[imfcval] [float] NOT NULL,
	[pack] [char](1) NOT NULL,
	[pkqty] [numeric](8, 3) NOT NULL,
	[lstrcvdate] [char](8) NOT NULL,
	[fqtyrcv] [numeric](12, 3) NOT NULL,
	[qtyrcv] [numeric](12, 3) NOT NULL,
	[porder] [numeric](6, 0) NOT NULL,
	[shadd] [char](1) NOT NULL,
	[shdpk] [numeric](8, 3) NOT NULL,
	[shdqty] [numeric](12, 3) NOT NULL,
	[frtqty] [numeric](12, 3) NOT NULL,
	[cmbkey] [char](24) NULL,
	[whno] [char](2) NULL,
	[folio] [int] NULL,
	[taxtype] [char](1) NULL,
	[item_vat] [numeric](12, 3) NULL,
	[item_price_net] [float] NULL,
	[item_fq_vat] [numeric](12, 3) NULL,
	[invdscamt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_oh]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_oh](
	[slcenter] [char](2) NOT NULL,
	[branch] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[custno] [char](6) NOT NULL,
	[custnm] [varchar](50) NOT NULL,
	[glser] [char](19) NOT NULL,
	[dsctype] [char](1) NOT NULL,
	[pstmode] [numeric](1, 0) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[fcyrate] [numeric](7, 2) NOT NULL,
	[duedate] [char](8) NOT NULL,
	[invttl] [float] NOT NULL,
	[invcst] [float] NOT NULL,
	[invdspc] [float] NOT NULL,
	[invdsvl] [float] NOT NULL,
	[valafds] [float] NOT NULL,
	[invpaid] [numeric](14, 2) NOT NULL,
	[caser] [char](19) NOT NULL,
	[entries] [numeric](5, 0) NOT NULL,
	[released] [bit] NOT NULL,
	[posted] [bit] NOT NULL,
	[fixrate] [numeric](7, 2) NOT NULL,
	[extamt] [numeric](14, 2) NOT NULL,
	[extser] [char](19) NOT NULL,
	[pricetp] [char](1) NOT NULL,
	[ischeque] [bit] NOT NULL,
	[chkno] [char](8) NOT NULL,
	[chkdate] [char](8) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[jvgenrt] [bit] NOT NULL,
	[imfcval] [numeric](14, 5) NOT NULL,
	[slcode] [char](2) NOT NULL,
	[rqstorder] [char](10) NOT NULL,
	[rcvdate] [char](8) NOT NULL,
	[lstrcvdate] [char](8) NOT NULL,
	[ordclosed] [bit] NOT NULL,
	[cstordrno] [char](16) NOT NULL,
	[isorder] [bit] NOT NULL,
	[rcvdtrn] [bit] NOT NULL,
	[puorder] [numeric](6, 0) NOT NULL,
	[carrier] [char](3) NULL,
	[vat_amt_rcvd] [float] NULL,
	[taxfree_sales] [float] NULL,
	[clnt_taxcode] [varchar](20) NULL,
	[clnt_kind] [char](1) NULL,
	[wh_rsvqty] [bit] NULL,
	[zatca_rounding] [bit] NULL,
	[vat_percent] [numeric](5, 2) NULL,
	[pricevattype] [numeric](1, 0) NULL,
 CONSTRAINT [PK_sales_oh_1] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_qd]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_qd](
	[slcenter] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[itemdesc] [char](30) NOT NULL,
	[qty] [float] NULL,
	[fqty] [numeric](10, 3) NOT NULL,
	[price] [float] NULL,
	[discpc] [numeric](6, 2) NOT NULL,
	[cost] [float] NOT NULL,
	[ds_acfm] [numeric](1, 0) NOT NULL,
	[sl_acfm] [numeric](1, 0) NOT NULL,
	[gclass] [char](8) NOT NULL,
	[custno] [char](6) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[barcode] [char](20) NOT NULL,
	[imfcval] [float] NOT NULL,
	[pack] [char](1) NOT NULL,
	[pkqty] [numeric](9, 3) NOT NULL,
	[shadd] [char](1) NULL,
	[shdpk] [numeric](9, 3) NOT NULL,
	[shdqty] [numeric](14, 3) NOT NULL,
	[frtqty] [numeric](12, 3) NOT NULL,
	[cmbkey] [char](24) NULL,
	[folio] [numeric](4, 0) NULL,
	[whno] [char](2) NULL,
	[item_Quoted] [bit] NULL,
	[dsc_amt] [float] NULL,
	[item_vat] [numeric](12, 3) NULL,
	[item_price_net] [float] NULL,
	[item_fq_vat] [numeric](12, 3) NULL,
	[invdscamt] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sales_qh]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sales_qh](
	[slcenter] [char](2) NOT NULL,
	[branch] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[company] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[invdate] [char](8) NOT NULL,
	[custno] [char](6) NOT NULL,
	[custnm] [varchar](50) NOT NULL,
	[glser] [char](19) NOT NULL,
	[dsctype] [char](1) NOT NULL,
	[pstmode] [numeric](1, 0) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[fcyrate] [numeric](7, 2) NOT NULL,
	[duedate] [char](8) NOT NULL,
	[invttl] [float] NOT NULL,
	[invcst] [float] NOT NULL,
	[invdspc] [float] NOT NULL,
	[invdsvl] [float] NOT NULL,
	[valafds] [float] NOT NULL,
	[invpaid] [numeric](14, 2) NOT NULL,
	[caser] [char](19) NOT NULL,
	[entries] [numeric](5, 0) NOT NULL,
	[released] [bit] NOT NULL,
	[posted] [bit] NOT NULL,
	[fixrate] [numeric](7, 2) NOT NULL,
	[extamt] [float] NOT NULL,
	[extser] [char](19) NOT NULL,
	[pricetp] [char](1) NOT NULL,
	[ischeque] [bit] NOT NULL,
	[chkno] [char](8) NOT NULL,
	[chkdate] [char](8) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[jvgenrt] [bit] NOT NULL,
	[imfcval] [numeric](14, 5) NOT NULL,
	[slcode] [char](2) NOT NULL,
	[modified] [bit] NOT NULL,
	[rcvdtrn] [bit] NOT NULL,
	[remarks] [varchar](65) NULL,
	[remarks2] [varchar](65) NULL,
	[usrid] [char](10) NULL,
	[vat_amt_rcvd] [float] NULL,
	[taxfree_sales] [float] NULL,
	[clnt_taxcode] [varchar](20) NULL,
	[clnt_kind] [char](1) NULL,
	[qhtype] [char](1) NULL,
	[qhstatus] [char](1) NULL,
	[newcstmrname] [varchar](50) NULL,
	[newcstmrcntct] [varchar](50) NULL,
	[cstmrmobile] [varchar](50) NULL,
	[fqtyval] [float] NULL,
	[zatca_rounding] [bit] NULL,
	[vat_percent] [numeric](5, 2) NULL,
	[pricevattype] [numeric](1, 0) NULL,
 CONSTRAINT [PK_sales_qh] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[salesmen]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[salesmen](
	[slcompany] [char](2) NOT NULL,
	[slcode] [char](2) NOT NULL,
	[slshort] [char](10) NOT NULL,
	[slname] [varchar](40) NOT NULL,
	[slcomm] [numeric](4, 2) NOT NULL,
	[clcomm] [numeric](4, 2) NOT NULL,
	[sltarget] [numeric](12, 2) NOT NULL,
	[cltarget] [numeric](12, 2) NOT NULL,
	[salesman] [bit] NOT NULL,
	[collector] [bit] NOT NULL,
	[sltype] [numeric](1, 0) NOT NULL,
	[lstcomm] [char](8) NOT NULL,
	[modified] [bit] NOT NULL,
	[sllname] [varchar](40) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[purshman] [bit] NOT NULL,
	[notify_type] [int] NULL,
	[notify_within] [int] NULL,
	[slemail] [varchar](60) NULL,
	[slmobile] [varchar](20) NULL,
	[usrid] [char](10) NULL,
	[slscmnact] [char](19) NULL,
	[crdt_limit] [float] NULL,
	[sl_center] [char](2) NULL,
 CONSTRAINT [PK_salesmen] PRIMARY KEY CLUSTERED 
(
	[slcompany] ASC,
	[slcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sdaad_dt]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sdaad_dt](
	[company] [char](2) NULL,
	[sdtype] [char](2) NULL,
	[refno] [numeric](6, 0) NULL,
	[sdsubscrbno] [char](20) NULL,
	[sdamount] [float] NULL,
	[sdlastpaid] [char](8) NULL,
	[sdlastamt] [float] NULL,
	[sdtext] [varchar](70) NULL,
	[sdtcode] [char](3) NULL,
	[folio] [int] NULL,
	[vat_amt_paid] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sdaad_hd]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sdaad_hd](
	[company] [char](2) NOT NULL,
	[sdtype] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[sdtext] [varchar](70) NULL,
	[sdtcode] [char](3) NULL,
	[caser] [char](19) NULL,
	[sddate] [char](8) NULL,
	[sdamount] [float] NULL,
	[released] [bit] NULL,
	[posted] [bit] NULL,
	[lastupdt] [char](8) NULL,
	[usrid] [char](10) NULL,
	[sdttlamt] [float] NULL,
	[rcvdtrn] [bit] NULL,
	[sdentries] [numeric](4, 0) NULL,
	[Vat_Percent] [numeric](5, 2) NULL,
	[sdttlvatamt] [float] NULL,
	[vat_included] [bit] NULL,
	[sdNoVat] [bit] NULL,
 CONSTRAINT [PK_sdaad_hd] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[sdtype] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sddtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sddtl](
	[dt_company] [char](2) NOT NULL,
	[dt_type] [char](2) NOT NULL,
	[dt_ref] [numeric](6, 0) NOT NULL,
	[dt_date] [char](8) NOT NULL,
	[dt_lcamt] [float] NOT NULL,
	[dt_paidamt] [float] NOT NULL,
	[dt_discamt] [float] NOT NULL,
	[dt_cucode] [char](6) NOT NULL,
	[dt_fcy] [char](3) NOT NULL,
	[dt_trxsrc] [char](2) NOT NULL,
	[dt_fcamt] [float] NOT NULL,
	[dt_fpydamt] [float] NOT NULL,
	[dt_fdscamt] [float] NOT NULL,
	[dt_lcaloc] [float] NOT NULL,
	[dt_fcaloc] [float] NOT NULL,
	[dt_aloctd] [char](1) NOT NULL,
	[dt_pdinv] [numeric](6, 0) NOT NULL,
	[dt_duedate] [char](8) NOT NULL,
	[dt_desc] [varchar](70) NOT NULL,
	[dt_chkno] [char](8) NOT NULL,
	[dt_chkdate] [char](8) NOT NULL,
	[dt_chkbnk] [char](2) NOT NULL,
	[dt_dbcr] [char](1) NOT NULL,
	[dt_ackey] [char](19) NOT NULL,
	[dt_folio] [numeric](4, 0) NOT NULL,
	[dt_rcvno] [numeric](6, 0) NOT NULL,
	[dt_lstdate] [char](8) NOT NULL,
	[tdscdays] [numeric](2, 0) NOT NULL,
	[tdscpcs] [numeric](4, 2) NOT NULL,
	[match] [bit] NOT NULL,
	[rplct_post] [bit] NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[dt_sucode] [char](6) NULL,
	[cstcode] [char](4) NULL,
	[taxcatId] [numeric](3, 0) NULL,
	[jdcstval] [float] NULL,
	[cstkey] [char](22) NULL,
	[vndr_taxcode] [varchar](20) NULL,
	[vndr_name] [varchar](50) NULL,
	[no_chng_col] [bit] NULL,
	[amtincldvat] [bit] NULL,
 CONSTRAINT [PK_sddtl] PRIMARY KEY CLUSTERED 
(
	[dt_company] ASC,
	[dt_type] ASC,
	[dt_ref] ASC,
	[dt_folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sdhdr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sdhdr](
	[hd_company] [char](2) NOT NULL,
	[hd_type] [char](2) NOT NULL,
	[hd_ref] [numeric](6, 0) NOT NULL,
	[hd_date] [char](8) NOT NULL,
	[hd_fcy] [char](3) NOT NULL,
	[hd_ftotal] [float] NOT NULL,
	[hd_fcyrate] [numeric](9, 6) NULL,
	[hd_ltotal] [float] NOT NULL,
	[hd_cucode] [char](6) NOT NULL,
	[hd_desc1] [varchar](70) NOT NULL,
	[hd_ser] [char](19) NOT NULL,
	[hd_rlsd] [bit] NOT NULL,
	[hd_posted] [bit] NOT NULL,
	[hd_trxsrc] [char](2) NOT NULL,
	[hd_sysdate] [char](8) NOT NULL,
	[hd_lcnet] [float] NOT NULL,
	[hd_fcnet] [float] NOT NULL,
	[hd_lccnet] [float] NOT NULL,
	[hd_fccnet] [float] NOT NULL,
	[isit_opst] [bit] NOT NULL,
	[opst_val] [float] NOT NULL,
	[opst_fcy] [char](3) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[modified] [bit] NOT NULL,
	[rcvdtrn] [bit] NOT NULL,
	[usrid] [char](10) NOT NULL,
	[clcode] [char](2) NOT NULL,
	[clcmnd] [bit] NOT NULL,
	[dscamt] [float] NOT NULL,
	[payinv] [bit] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Vat_Percent] [numeric](5, 2) NULL,
	[serial_no] [int] NULL,
	[brxfrm] [char](2) NULL,
	[caser] [char](19) NULL,
	[ctype] [numeric](1, 0) NULL,
	[datetime_stamp] [datetime] NULL,
	[clnt_kind] [char](1) NULL,
	[hide_jv] [bit] NULL,
 CONSTRAINT [PK_sdhdr] PRIMARY KEY CLUSTERED 
(
	[hd_company] ASC,
	[hd_type] ASC,
	[hd_ref] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[slclass]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[slclass](
	[company] [char](2) NOT NULL,
	[name] [char](20) NOT NULL,
	[cmbkey] [char](12) NOT NULL,
	[mgroup] [char](2) NOT NULL,
	[sgroup] [char](2) NOT NULL,
	[category] [char](2) NOT NULL,
	[sercsh] [char](19) NOT NULL,
	[sercrd] [char](19) NOT NULL,
	[serrch] [char](19) NOT NULL,
	[serrcr] [char](19) NOT NULL,
	[serdsc] [char](19) NOT NULL,
	[serpcsh] [char](19) NOT NULL,
	[serpcrd] [char](19) NOT NULL,
	[serprch] [char](19) NOT NULL,
	[serprcr] [char](19) NOT NULL,
	[serpdsc] [char](19) NOT NULL,
	[sgroup3] [char](3) NOT NULL,
	[sgroup4] [char](3) NOT NULL,
	[modified] [bit] NOT NULL,
	[cstcode] [char](4) NOT NULL,
	[lname] [char](20) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[srslcst] [char](19) NOT NULL,
 CONSTRAINT [PK_slclass] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[cmbkey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[slfcypay]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[slfcypay](
	[company] [char](2) NOT NULL,
	[invtype] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[fcamt] [float] NOT NULL,
	[fcyrate] [numeric](10, 5) NOT NULL,
	[lcamt] [float] NULL,
	[srlno] [numeric](2, 0) NOT NULL,
	[fixrate] [numeric](10, 5) NULL,
 CONSTRAINT [PK_slfcypay] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[invtype] ASC,
	[refno] ASC,
	[srlno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[slglsscc]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[slglsscc](
	[cccode] [tinyint] NOT NULL,
	[ccname] [varchar](50) NULL,
	[cclname] [varchar](50) NULL,
	[chrgprcnt] [numeric](9, 5) NULL,
	[ccmada] [bit] NULL,
	[ccconus] [bit] NULL,
	[ccinactive] [bit] NULL,
	[lastupdt] [char](8) NULL,
	[is_tax_applied] [bit] NULL,
 CONSTRAINT [PK_credit_cards] PRIMARY KEY CLUSTERED 
(
	[cccode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[st_slsord_dtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[st_slsord_dtl](
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[branch] [char](2) NOT NULL,
	[trtype] [char](2) NULL,
	[qty] [float] NOT NULL,
	[fqty] [numeric](11, 3) NULL,
	[whno] [char](2) NOT NULL,
	[binno] [char](6) NOT NULL,
	[lcost] [float] NULL,
	[trdate] [char](8) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[src] [char](2) NOT NULL,
	[fcost] [float] NULL,
	[expdate] [char](8) NULL,
	[towhno] [char](2) NULL,
	[tobinno] [char](6) NULL,
	[barcode] [char](20) NOT NULL,
	[cmbkey] [char](24) NOT NULL,
	[pack] [char](1) NULL,
	[folio] [numeric](7, 0) NOT NULL,
 CONSTRAINT [PK_st_slsord_dtl] PRIMARY KEY CLUSTERED 
(
	[branch] ASC,
	[refno] ASC,
	[folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[starea]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[starea](
	[name] [char](20) NOT NULL,
	[cmbkey] [char](6) NOT NULL,
	[govrn] [char](2) NOT NULL,
	[city] [char](2) NOT NULL,
	[region] [char](2) NOT NULL,
	[modified] [bit] NOT NULL,
	[lname] [char](20) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[pkey] [int] NOT NULL,
	[chkey] [int] NOT NULL,
 CONSTRAINT [PK_starea] PRIMARY KEY CLUSTERED 
(
	[cmbkey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stasmbld]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stasmbld](
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[asmitemno] [char](16) NOT NULL,
	[asmunicode] [char](6) NOT NULL,
	[cmbkey] [char](24) NOT NULL,
	[qtyneeded] [numeric](8, 3) NOT NULL,
 CONSTRAINT [PK_stasmbld] PRIMARY KEY CLUSTERED 
(
	[itemno] ASC,
	[unicode] ASC,
	[asmitemno] ASC,
	[asmunicode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stattrbname]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stattrbname](
	[atn_id] [char](2) NOT NULL,
	[atn_name] [varchar](15) NULL,
	[atn_lname] [varchar](15) NULL,
	[atn_type] [numeric](1, 0) NULL,
	[lastupdt] [char](8) NULL,
 CONSTRAINT [PK_orattrbname] PRIMARY KEY CLUSTERED 
(
	[atn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stbins]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stbins](
	[branch] [char](2) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[whno] [char](2) NOT NULL,
	[binno] [char](6) NOT NULL,
	[qty] [float] NULL,
	[rsvqty] [float] NULL,
	[openbal] [float] NULL,
	[lcost] [float] NOT NULL,
	[fcost] [float] NOT NULL,
	[openlcost] [float] NOT NULL,
	[openfcost] [float] NOT NULL,
	[expdate] [char](8) NOT NULL,
 CONSTRAINT [PK_stbins_1] PRIMARY KEY CLUSTERED 
(
	[branch] ASC,
	[itemno] ASC,
	[unicode] ASC,
	[whno] ASC,
	[binno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stbranch]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stbranch](
	[name] [varchar](40) NOT NULL,
	[brnno] [char](2) NOT NULL,
	[govrn] [char](2) NULL,
	[city] [char](2) NULL,
	[area] [char](2) NULL,
	[cmbkey] [char](6) NULL,
	[company] [char](2) NULL,
	[cashser] [char](19) NULL,
	[modified] [bit] NULL,
	[bcserial] [numeric](13, 0) NULL,
	[jv_01] [numeric](6, 0) NULL,
	[jv_02] [numeric](6, 0) NULL,
	[jv_03] [numeric](6, 0) NULL,
	[jv_04] [numeric](6, 0) NULL,
	[jv_05] [numeric](6, 0) NULL,
	[jv_06] [numeric](6, 0) NULL,
	[jv_07] [numeric](6, 0) NULL,
	[jv_08] [numeric](6, 0) NULL,
	[jv_09] [numeric](6, 0) NULL,
	[jv_10] [numeric](6, 0) NULL,
	[jv_11] [numeric](6, 0) NULL,
	[jv_12] [numeric](6, 0) NULL,
	[jv_13] [numeric](6, 0) NULL,
	[jv_14] [numeric](6, 0) NULL,
	[jv_18] [numeric](6, 0) NULL,
	[jv_19] [numeric](6, 0) NULL,
	[jv_20] [numeric](6, 0) NULL,
	[jv_21] [numeric](6, 0) NULL,
	[jv_22] [numeric](6, 0) NULL,
	[jv_23] [numeric](6, 0) NULL,
	[jv_24] [numeric](6, 0) NULL,
	[jv_26] [numeric](6, 0) NULL,
	[jv_27] [numeric](6, 0) NULL,
	[jv_28] [numeric](6, 0) NULL,
	[jv_30] [numeric](6, 0) NULL,
	[jv_31] [numeric](6, 0) NULL,
	[jv_32] [numeric](6, 0) NULL,
	[jv_33] [numeric](6, 0) NULL,
	[jv_34] [numeric](8, 0) NULL,
	[calgl] [numeric](2, 0) NULL,
	[calar] [numeric](2, 0) NULL,
	[calap] [numeric](2, 0) NULL,
	[calst] [numeric](2, 0) NULL,
	[srdiff] [char](19) NULL,
	[lname] [varchar](30) NULL,
	[lastupdt] [char](8) NULL,
	[jv_45] [numeric](10, 0) NULL,
	[stkxtoser] [char](19) NULL,
	[stkxfmser] [char](19) NULL,
	[baddress] [varchar](60) NULL,
	[lbaddress] [char](10) NULL,
	[phone] [varchar](40) NULL,
	[fax] [char](20) NULL,
	[jv_17] [numeric](6, 0) NULL,
	[jv_16] [numeric](6, 0) NULL,
	[jv_46] [numeric](6, 0) NULL,
	[dscalwser] [char](19) NULL,
	[dscernser] [char](19) NULL,
	[jv_101] [int] NULL,
	[manualser] [bit] NULL,
	[smsdispname] [char](11) NULL,
	[smsuser] [int] NULL,
	[smsfooter] [char](40) NULL,
	[rebate_act] [char](19) NULL,
	[fm_price1] [numeric](6, 0) NULL,
	[to_price1] [numeric](6, 0) NULL,
	[doz_price1] [numeric](6, 0) NULL,
	[ctn_price1] [numeric](6, 0) NULL,
	[fm_price2] [numeric](6, 0) NULL,
	[to_price2] [numeric](6, 0) NULL,
	[doz_price2] [numeric](6, 0) NULL,
	[ctn_price2] [numeric](6, 0) NULL,
	[fm_price3] [numeric](6, 0) NULL,
	[to_price3] [numeric](6, 0) NULL,
	[doz_price3] [numeric](6, 0) NULL,
	[ctn_price3] [numeric](6, 0) NULL,
	[pricetp] [char](1) NULL,
	[rebate_loss] [char](19) NULL,
	[sysno] [numeric](2, 0) NULL,
	[No_round_nm] [bit] NULL,
	[PriceVatType] [numeric](1, 0) NULL,
	[mkt_frc_rounding] [bit] NULL,
	[is_dsc_amt] [bit] NULL,
	[auto_dsc_hll] [bit] NULL,
	[max_dsc_hll] [numeric](3, 2) NULL,
	[pos_type] [int] NULL,
	[jv_51] [int] NULL,
	[sc_lvlno] [int] NULL,
	[vat_paid_act] [char](19) NULL,
	[jv_105] [int] NULL,
	[jv_106] [int] NULL,
	[jv_107] [int] NULL,
	[jv_108] [int] NULL,
	[jv_109] [int] NULL,
	[jv_110] [int] NULL,
	[Jv_37] [int] NULL,
	[jv_55] [numeric](10, 0) NULL,
	[jv_56] [numeric](6, 0) NULL,
	[JV_60] [int] NULL,
	[JV_61] [int] NULL,
	[district] [varchar](50) NULL,
	[district_l] [varchar](50) NULL,
	[city_text] [varchar](50) NULL,
	[city_text_l] [varchar](50) NULL,
	[postal_code] [varchar](20) NULL,
	[bldg_no] [varchar](50) NULL,
	[bldg_no_l] [varchar](50) NULL,
	[street_name] [varchar](50) NULL,
	[street_name_l] [varchar](50) NULL,
	[area_name] [varchar](50) NULL,
	[area_name_l] [varchar](50) NULL,
	[extra_address_no] [varchar](50) NULL,
	[extra_address_no_l] [varchar](50) NULL,
	[crdt_limit] [float] NULL,
	[Street_Name2] [varchar](50) NULL,
	[Street_Name2_l] [varchar](50) NULL,
	[Group_VAT_ID] [varchar](30) NULL,
	[Other_id_SchemeID] [varchar](20) NULL,
	[country_code] [int] NULL,
	[Other_Scheme_Type] [varchar](10) NULL,
	[vat_rcvd_act] [char](19) NULL,
	[remote_br_sqlserver] [varchar](45) NULL,
	[rvnuact] [varchar](19) NULL,
	[jv_301] [int] NULL,
	[jv_205] [int] NULL,
	[jv_209] [int] NULL,
	[jv_210] [int] NULL,
	[jv_211] [int] NULL,
	[jv_212] [int] NULL,
	[jv_213] [int] NULL,
	[jv_214] [int] NULL,
	[jv_215] [int] NULL,
	[jv_216] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stbrand]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stbrand](
	[brand_id] [numeric](4, 0) NOT NULL,
	[name] [char](15) NOT NULL,
	[lname] [char](15) NOT NULL,
 CONSTRAINT [PK_stbrand] PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stbrprice]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stbrprice](
	[company] [char](2) NOT NULL,
	[slcenter] [char](2) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[lprice1] [numeric](11, 2) NOT NULL,
	[lprice2] [numeric](11, 2) NOT NULL,
	[lprice3] [numeric](11, 2) NOT NULL,
	[maxdisc1] [numeric](4, 2) NOT NULL,
	[maxdisc2] [numeric](4, 2) NOT NULL,
	[maxdisc3] [numeric](4, 2) NOT NULL,
	[mnmprice] [numeric](11, 2) NOT NULL,
	[pprice1] [numeric](11, 2) NOT NULL,
	[pprice2] [numeric](11, 2) NULL,
	[pprice3] [numeric](11, 2) NULL,
	[modelno] [char](16) NULL,
	[promotion] [bit] NOT NULL,
	[prm_start] [char](20) NULL,
	[prm_end] [char](20) NULL,
	[slsprsnt] [numeric](9, 2) NULL,
	[fprice1] [numeric](11, 2) NULL,
	[fprice2] [numeric](11, 2) NULL,
	[fprice3] [numeric](11, 2) NULL,
	[modified] [bit] NOT NULL,
	[lastupdt] [char](8) NULL,
 CONSTRAINT [PK_stbrprice_1] PRIMARY KEY CLUSTERED 
(
	[company] ASC,
	[slcenter] ASC,
	[itemno] ASC,
	[unicode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stclass]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stclass](
	[name] [char](20) NOT NULL,
	[cmbkey] [char](12) NOT NULL,
	[mgroup] [char](2) NOT NULL,
	[sgroup] [char](2) NOT NULL,
	[category] [char](2) NOT NULL,
	[sercsh] [char](19) NOT NULL,
	[sercrd] [char](19) NOT NULL,
	[serrch] [char](19) NOT NULL,
	[serrcr] [char](19) NOT NULL,
	[serdsc] [char](19) NOT NULL,
	[serpcsh] [char](19) NOT NULL,
	[serpcrd] [char](19) NOT NULL,
	[serprch] [char](19) NOT NULL,
	[serprcr] [char](19) NOT NULL,
	[serpdsc] [char](19) NOT NULL,
	[sgroup3] [char](3) NOT NULL,
	[sgroup4] [char](3) NOT NULL,
	[modified] [bit] NOT NULL,
	[pkey] [int] NOT NULL,
	[chkey] [int] NOT NULL,
	[lname] [char](20) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[max_sl_limit] [numeric](12, 3) NULL,
 CONSTRAINT [PK_stclass] PRIMARY KEY CLUSTERED 
(
	[cmbkey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stcommission]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stcommission](
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[commtype] [numeric](1, 0) NOT NULL,
	[commission] [numeric](9, 3) NOT NULL,
	[cmntarget] [numeric](12, 3) NOT NULL,
	[InActive] [bit] NOT NULL,
	[cmsn_onQty] [bit] NOT NULL,
	[cmsn_calctype] [numeric](1, 0) NULL,
	[cmsn_perqty] [float] NULL,
	[cmsn_payval] [float] NULL,
	[cmsn_remarks] [varchar](40) NULL,
 CONSTRAINT [PK_stcommission] PRIMARY KEY CLUSTERED 
(
	[itemno] ASC,
	[unicode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stcosttype]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stcosttype](
	[branch] [char](2) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[lastlcost] [float] NULL,
	[highlcost] [float] NULL,
	[lowlcost] [float] NULL,
	[lstrcvdate] [char](8) NULL,
	[lastfcost] [float] NULL,
	[frstrcvdate] [char](8) NULL,
	[frstrcvd01] [char](8) NULL,
	[lastrcvd01] [char](8) NULL,
	[lastlcost01] [float] NULL,
	[frstlcost01] [float] NULL,
	[pufrstlcost] [float] NULL,
	[brlastissue] [char](8) NULL,
 CONSTRAINT [PK_stcosttype_1] PRIMARY KEY CLUSTERED 
(
	[branch] ASC,
	[itemno] ASC,
	[unicode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stcrtpuinv]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stcrtpuinv](
	[branch] [char](2) NOT NULL,
	[splycode] [char](19) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[splyinv] [char](20) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[dbxyr] [char](2) NULL,
	[idate] [char](8) NULL,
	[lastupdt] [char](8) NULL,
	[rplct_post] [bit] NULL,
	[slcode] [char](2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stdtl]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stdtl](
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[branch] [char](2) NOT NULL,
	[trtype] [char](2) NOT NULL,
	[qty] [float] NULL,
	[fqty] [numeric](11, 3) NOT NULL,
	[whno] [char](2) NOT NULL,
	[binno] [char](6) NOT NULL,
	[lcost] [float] NOT NULL,
	[trdate] [char](8) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[sysdate] [char](8) NOT NULL,
	[src] [char](2) NOT NULL,
	[lprice] [float] NOT NULL,
	[fcost] [float] NULL,
	[fprice] [float] NULL,
	[expdate] [char](8) NULL,
	[towhno] [char](2) NULL,
	[tobinno] [char](6) NULL,
	[barcode] [char](20) NOT NULL,
	[cmbkey] [char](24) NOT NULL,
	[discpc] [numeric](6, 2) NULL,
	[pack] [char](1) NULL,
	[shdpk] [numeric](10, 3) NULL,
	[shdqty] [float] NULL,
	[folio] [numeric](7, 0) NOT NULL,
	[rplct_post] [bit] NULL,
	[q_frt] [numeric](7, 0) NULL,
 CONSTRAINT [PK_stdtl] PRIMARY KEY CLUSTERED 
(
	[branch] ASC,
	[trtype] ASC,
	[refno] ASC,
	[folio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sthdr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sthdr](
	[branch] [char](2) NOT NULL,
	[trtype] [char](2) NOT NULL,
	[refno] [numeric](6, 0) NOT NULL,
	[trdate] [char](8) NOT NULL,
	[description] [varchar](70) NULL,
	[amnttl] [float] NOT NULL,
	[costttl] [float] NOT NULL,
	[sysdate] [char](8) NULL,
	[src] [char](2) NOT NULL,
	[released] [bit] NOT NULL,
	[posted] [bit] NOT NULL,
	[fcy] [char](3) NOT NULL,
	[fcyrate] [float] NULL,
	[whno] [char](2) NOT NULL,
	[entries] [numeric](6, 0) NULL,
	[lastupdt] [char](8) NULL,
	[towhno] [char](2) NULL,
	[modified] [bit] NOT NULL,
	[rcvdtrn] [bit] NULL,
	[custno] [char](19) NULL,
	[usrid] [char](10) NOT NULL,
	[brsupp] [char](19) NULL,
	[tobrno] [char](2) NULL,
	[brxref] [numeric](6, 0) NULL,
	[glref] [numeric](6, 0) NULL,
	[isbrtrx] [bit] NULL,
	[asmtype] [numeric](1, 0) NULL,
	[repost] [bit] NULL,
	[items_rcvd] [bit] NULL,
	[trx_printed] [numeric](2, 0) NULL,
	[pricetp] [char](1) NULL,
	[Damaged] [bit] NULL,
 CONSTRAINT [PK_sthdr] PRIMARY KEY CLUSTERED 
(
	[branch] ASC,
	[trtype] ASC,
	[refno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stitembc]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stitembc](
	[pbarcode] [char](20) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NULL,
	[cmbkey] [char](24) NOT NULL,
	[pack] [char](10) NOT NULL,
	[pkqty] [numeric](10, 3) NOT NULL,
	[lprice1] [float] NULL,
	[weight] [numeric](12, 3) NULL,
	[mnmprice] [numeric](11, 2) NULL,
	[itext] [varchar](30) NULL,
	[litext] [varchar](15) NULL,
	[pkorder] [numeric](2, 0) NULL,
	[lastrcvd] [char](8) NULL,
	[lprice2] [float] NULL,
 CONSTRAINT [PK_stitembc] PRIMARY KEY CLUSTERED 
(
	[pbarcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stitembc_brprice]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stitembc_brprice](
	[branch] [char](2) NOT NULL,
	[pbarcode] [char](20) NOT NULL,
	[cmbkey] [char](24) NOT NULL,
	[lprice1] [numeric](11, 2) NULL,
	[mnmprice] [numeric](11, 2) NULL,
	[lprice2] [numeric](11, 2) NULL,
 CONSTRAINT [PK_stitembc_brprice] PRIMARY KEY CLUSTERED 
(
	[branch] ASC,
	[pbarcode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stitempictures]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stitempictures](
	[cmbkey] [char](24) NOT NULL,
	[picture_order] [int] NOT NULL,
	[picture_name] [varchar](200) NULL,
	[default_picture] [bit] NULL,
	[item_image] [image] NULL,
 CONSTRAINT [PK_stitempictures_1] PRIMARY KEY CLUSTERED 
(
	[cmbkey] ASC,
	[picture_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stitems]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stitems](
	[name] [varchar](45) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[mgroup] [char](2) NOT NULL,
	[sgroup] [char](2) NOT NULL,
	[category] [char](2) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[classkey] [char](12) NOT NULL,
	[exdatealw] [bit] NOT NULL,
	[noofsbitem] [int] NOT NULL,
	[modified] [bit] NOT NULL,
	[sgroup3] [char](3) NOT NULL,
	[sgroup4] [char](3) NOT NULL,
	[company] [char](2) NOT NULL,
	[lname] [varchar](40) NOT NULL,
	[country] [numeric](3, 0) NOT NULL,
	[season] [char](1) NOT NULL,
	[splycode] [char](19) NOT NULL,
	[splylcact] [bit] NOT NULL,
	[itemtype] [char](1) NOT NULL,
	[prntasmitm] [bit] NOT NULL,
	[prmdesc] [char](8) NOT NULL,
	[scndesc] [char](8) NOT NULL,
	[cmpprcnt] [bit] NOT NULL,
	[dsctype] [char](1) NOT NULL,
	[brand_id] [numeric](4, 0) NOT NULL,
	[msplycode] [char](6) NOT NULL,
	[modelno] [char](16) NULL,
	[nosales] [bit] NULL,
	[vprice] [numeric](13, 2) NULL,
	[fix_barcode] [bit] NULL,
	[taxtype] [char](1) NULL,
	[taxfree] [bit] NULL,
 CONSTRAINT [PK_stitems] PRIMARY KEY CLUSTERED 
(
	[itemno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stitmphoto]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stitmphoto](
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[remarks] [varchar](250) NULL,
	[ipicture] [varchar](80) NULL,
	[ord_qty] [float] NULL,
	[mnimumdt] [char](8) NULL,
	[cust_pctg] [float] NULL,
	[is_double_width] [bit] NULL,
	[is_price_per_length] [bit] NULL,
	[is_accessory_stk_item] [bit] NULL,
	[dsc_amt1] [float] NULL,
	[dsc_amt2] [float] NULL,
	[dsc_amt3] [float] NULL,
	[usrid] [varchar](10) NULL,
	[usrid_lstchg] [varchar](10) NULL,
	[exemption_reason_code] [varchar](20) NULL,
	[onlinesales] [bit] NULL,
	[extra_tax_p] [numeric](6, 2) NULL,
	[startdate] [char](8) NULL,
	[enddate] [char](8) NULL,
 CONSTRAINT [PK_stitmphoto] PRIMARY KEY CLUSTERED 
(
	[itemno] ASC,
	[unicode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stitmsply]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stitmsply](
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[branch] [char](2) NOT NULL,
	[splycode] [char](19) NOT NULL,
	[fcy] [char](3) NOT NULL,
	[splylcact] [bit] NULL,
	[msplycode] [char](6) NULL,
	[lrcvdate] [char](8) NULL,
	[lastlcost] [float] NULL,
	[lastfcost] [float] NULL,
	[splyitemno] [varchar](20) NULL,
	[lastupdt] [char](8) NULL,
 CONSTRAINT [PK_stitmsply] PRIMARY KEY CLUSTERED 
(
	[branch] ASC,
	[itemno] ASC,
	[unicode] ASC,
	[splycode] ASC,
	[fcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stprice]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stprice](
	[name] [char](15) NOT NULL,
	[code] [char](1) NOT NULL,
	[disc] [char](8) NULL,
	[lprice] [char](8) NULL,
	[fprice] [char](8) NULL,
	[minsal] [numeric](9, 2) NULL,
	[maxsal] [numeric](9, 2) NULL,
	[modified] [bit] NULL,
	[lname] [char](15) NULL,
	[lastupdt] [char](8) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stunits]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stunits](
	[name] [char](8) NOT NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[moved] [bit] NOT NULL,
	[openlcost] [float] NOT NULL,
	[lcost] [float] NOT NULL,
	[lprice1] [numeric](11, 2) NOT NULL,
	[fprice1] [numeric](11, 2) NOT NULL,
	[maxdisc1] [numeric](4, 2) NOT NULL,
	[lprice2] [float] NULL,
	[fprice2] [numeric](11, 2) NOT NULL,
	[maxdisc2] [numeric](4, 2) NOT NULL,
	[lprice3] [numeric](11, 2) NOT NULL,
	[fprice3] [numeric](11, 2) NOT NULL,
	[maxdisc3] [numeric](4, 2) NOT NULL,
	[openfcost] [float] NOT NULL,
	[fcost] [float] NOT NULL,
	[lrcvdate] [char](8) NOT NULL,
	[lastissue] [char](8) NOT NULL,
	[openbal] [float] NULL,
	[curbal] [float] NULL,
	[rsvqty] [float] NULL,
	[minstk] [numeric](11, 3) NOT NULL,
	[maxstk] [numeric](11, 3) NOT NULL,
	[orderlevel] [numeric](11, 2) NOT NULL,
	[leadday] [numeric](3, 0) NOT NULL,
	[Xdecimal] [bit] NOT NULL,
	[barcode] [char](20) NOT NULL,
	[pack1] [char](1) NOT NULL,
	[pkqty1] [numeric](10, 3) NOT NULL,
	[pack2] [char](1) NOT NULL,
	[pkqty2] [numeric](10, 3) NOT NULL,
	[pack3] [char](1) NOT NULL,
	[pkqty3] [numeric](8, 3) NOT NULL,
	[company] [char](2) NOT NULL,
	[modified] [bit] NOT NULL,
	[pack0] [char](1) NOT NULL,
	[packtp] [char](1) NOT NULL,
	[scnname] [char](8) NOT NULL,
	[crtdate] [char](8) NOT NULL,
	[inactive] [bit] NOT NULL,
	[prmcode] [char](3) NOT NULL,
	[scncode] [char](3) NOT NULL,
	[cmbkey] [char](24) NOT NULL,
	[mnmprice] [numeric](11, 2) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[modelno] [char](16) NOT NULL,
	[splyitemno] [varchar](20) NULL,
	[splyinv] [varchar](20) NULL,
	[invprice] [float] NULL,
	[invqty] [numeric](10, 3) NULL,
	[invpk] [char](1) NULL,
	[pp2] [numeric](6, 2) NULL,
	[pp3] [numeric](6, 2) NULL,
 CONSTRAINT [PK_stunits_1] PRIMARY KEY CLUSTERED 
(
	[itemno] ASC,
	[unicode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stwhous]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stwhous](
	[name] [char](20) NOT NULL,
	[whno] [char](2) NOT NULL,
	[branch] [char](2) NOT NULL,
	[manager] [varchar](30) NOT NULL,
	[phone] [char](9) NOT NULL,
	[address] [varchar](30) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[srwhs] [char](19) NOT NULL,
	[modified] [bit] NOT NULL,
	[lname] [char](20) NOT NULL,
	[fax] [char](20) NOT NULL,
	[prnt_fsh] [bit] NULL,
	[ac_end_prd] [char](19) NULL,
	[cstcode] [char](4) NULL,
	[no_autosales] [bit] NULL,
	[sc_code] [char](6) NULL,
	[suspended] [bit] NULL,
	[binsrlno] [char](6) NULL,
	[xfrfm_mustbinnno] [bit] NULL,
	[xfrto_mustbinnno] [bit] NULL,
 CONSTRAINT [PK_stwhous] PRIMARY KEY CLUSTERED 
(
	[whno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[supplier]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[supplier](
	[cu_name] [varchar](50) NOT NULL,
	[cu_company] [char](2) NOT NULL,
	[cu_code] [char](6) NOT NULL,
	[cu_class] [char](2) NOT NULL,
	[cu_addrs] [varchar](50) NOT NULL,
	[cu_tel] [varchar](25) NOT NULL,
	[cu_fax] [char](10) NOT NULL,
	[cu_tlx] [char](10) NOT NULL,
	[cu_email] [varchar](30) NOT NULL,
	[cu_cntactp] [char](20) NOT NULL,
	[cu_title] [char](20) NOT NULL,
	[cu_crlmt] [numeric](14, 2) NOT NULL,
	[cu_pymnt] [numeric](3, 0) NOT NULL,
	[cu_status] [numeric](1, 0) NOT NULL,
	[cu_opnbal] [float] NULL,
	[cu_curbal] [float] NULL,
	[cf_fcy] [char](3) NOT NULL,
	[cf_opnfcy] [float] NULL,
	[cf_curfcy] [float] NULL,
	[cu_xrf] [char](6) NOT NULL,
	[cu_alwcr] [bit] NOT NULL,
	[cu_ctlser] [char](19) NOT NULL,
	[lastupdt] [char](8) NOT NULL,
	[cu_lcaloc] [float] NULL,
	[cu_fcaloc] [float] NULL,
	[modified] [bit] NOT NULL,
	[cmncode] [char](8) NOT NULL,
	[cu_lname] [varchar](40) NOT NULL,
	[cu_city] [char](6) NULL,
	[cu_country] [numeric](3, 0) NOT NULL,
	[cu_laddrs] [varchar](50) NOT NULL,
	[cu_mobile] [varchar](25) NOT NULL,
	[cu_sendsms] [bit] NULL,
	[whno] [char](2) NULL,
	[vndr_taxcode] [varchar](20) NULL,
	[taxFree] [bit] NULL,
	[cu_kind] [char](1) NULL,
	[section] [char](6) NULL,
	[PriceIncludeVat] [bit] NULL,
	[cu_type] [char](1) NULL,
	[usrid] [char](10) NULL,
	[usridchg] [char](10) NULL,
	[Added_date] [char](8) NULL,
 CONSTRAINT [PK_supplier] PRIMARY KEY CLUSTERED 
(
	[cu_company] ASC,
	[cu_code] ASC,
	[cf_fcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[supplier_ei]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[supplier_ei](
	[cu_company] [char](2) NOT NULL,
	[cu_code] [char](6) NOT NULL,
	[cf_fcy] [char](3) NOT NULL,
	[district] [varchar](50) NULL,
	[district_l] [varchar](50) NULL,
	[city_text] [varchar](50) NULL,
	[city_text_l] [varchar](50) NULL,
	[country_code] [numeric](3, 0) NULL,
	[postal_code] [varchar](20) NULL,
	[Other_id_SchemeID] [varchar](20) NULL,
	[bldg_no] [varchar](50) NULL,
	[bldg_no_l] [varchar](50) NULL,
	[street_name] [varchar](50) NULL,
	[street_name_l] [varchar](50) NULL,
	[area_name] [varchar](50) NULL,
	[area_name_l] [varchar](50) NULL,
	[extra_address_no] [varchar](50) NULL,
	[extra_address_no_l] [varchar](50) NULL,
	[street_name2] [varchar](50) NULL,
	[street_name2_l] [varchar](50) NULL,
	[Group_VAT_ID] [varchar](30) NULL,
	[Other_Scheme_Type] [varchar](10) NULL,
 CONSTRAINT [PK_supplier_ei] PRIMARY KEY CLUSTERED 
(
	[cu_company] ASC,
	[cu_code] ASC,
	[cf_fcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysgp]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysgp](
	[grpid] [char](10) NOT NULL,
	[groupname] [varchar](30) NOT NULL,
	[formkey] [text] NOT NULL,
	[formsel] [text] NOT NULL,
	[formname] [text] NOT NULL,
	[showcost] [bit] NOT NULL,
	[acssdisc] [bit] NOT NULL,
	[acssfqty] [bit] NOT NULL,
	[chgprice] [bit] NOT NULL,
	[undrcost] [bit] NOT NULL,
	[undrmin] [bit] NOT NULL,
	[belowbal] [bit] NOT NULL,
	[uchgpas] [bit] NOT NULL,
	[shwacprtct] [bit] NOT NULL,
	[useprice1] [bit] NOT NULL,
	[useprice2] [bit] NOT NULL,
	[useprice3] [bit] NOT NULL,
	[maxdsc] [numeric](4, 2) NOT NULL,
	[maxfqty] [numeric](6, 2) NOT NULL,
	[usrbrn] [text] NOT NULL,
	[msuser] [bit] NOT NULL,
	[uspright] [text] NOT NULL,
	[uswhalw] [text] NOT NULL,
	[uscntralw] [text] NOT NULL,
	[usdptalw] [text] NOT NULL,
	[uslatin] [bit] NOT NULL,
	[crdtsales] [bit] NOT NULL,
	[usslcsh] [bit] NOT NULL,
	[usslcrd] [bit] NOT NULL,
	[usslrcsh] [bit] NOT NULL,
	[usslrcrd] [bit] NOT NULL,
	[uspucsh] [bit] NOT NULL,
	[uspucrd] [bit] NOT NULL,
	[uspurcsh] [bit] NOT NULL,
	[uspurcrd] [bit] NOT NULL,
	[usjv] [bit] NOT NULL,
	[usrcv] [bit] NOT NULL,
	[usiss] [bit] NOT NULL,
	[uschqrcv] [bit] NOT NULL,
	[uschqiss] [bit] NOT NULL,
	[ustrnsin] [bit] NOT NULL,
	[ustrnsout] [bit] NOT NULL,
	[usbnkin] [bit] NOT NULL,
	[uscredit] [bit] NOT NULL,
	[usdebit] [bit] NOT NULL,
	[ussuspend] [bit] NOT NULL,
	[actallow] [text] NOT NULL,
	[openallow] [bit] NOT NULL,
	[cstallow] [text] NOT NULL,
	[editothers] [bit] NOT NULL,
	[usalwchgprs] [bit] NOT NULL,
	[dsplyothers] [bit] NOT NULL,
	[chgperiod] [bit] NOT NULL,
	[chgtdate] [bit] NOT NULL,
	[alwprntrpt] [bit] NOT NULL,
	[ussctnalw] [text] NULL,
 CONSTRAINT [PK_sysgp] PRIMARY KEY CLUSTERED 
(
	[grpid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysuse]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysuse](
	[username] [char](10) NOT NULL,
	[formkey] [text] NULL,
	[formsel] [text] NULL,
	[formname] [text] NULL,
	[password] [char](100) NOT NULL,
	[fullname] [varchar](30) NULL,
	[showcost] [bit] NULL,
	[acssdisc] [bit] NULL,
	[chgprice] [bit] NULL,
	[acssfqty] [bit] NULL,
	[undrcost] [bit] NULL,
	[undrmin] [bit] NULL,
	[belowbal] [bit] NULL,
	[grp] [text] NULL,
	[company] [char](2) NULL,
	[uchgpas] [bit] NULL,
	[shwacprtct] [bit] NULL,
	[useprice1] [bit] NULL,
	[useprice2] [bit] NULL,
	[useprice3] [bit] NULL,
	[maxdsc] [numeric](4, 2) NULL,
	[maxfqty] [numeric](6, 2) NULL,
	[currate] [numeric](6, 3) NULL,
	[usrbrn] [text] NULL,
	[msuser] [bit] NULL,
	[uspright] [text] NULL,
	[uswhalw] [text] NULL,
	[uscntralw] [text] NULL,
	[usdptalw] [text] NULL,
	[uslatin] [bit] NULL,
	[usslcsh] [bit] NULL,
	[usslcrd] [bit] NULL,
	[usslrcsh] [bit] NULL,
	[usslrcrd] [bit] NULL,
	[uspucsh] [bit] NULL,
	[uspucrd] [bit] NULL,
	[uspurcsh] [bit] NULL,
	[uspurcrd] [bit] NULL,
	[usjv] [bit] NULL,
	[usrcv] [bit] NULL,
	[usiss] [bit] NULL,
	[uschqrcv] [bit] NULL,
	[uschqiss] [bit] NULL,
	[ustrnsin] [bit] NULL,
	[ustrnsout] [bit] NULL,
	[usbnkin] [bit] NULL,
	[uscredit] [bit] NULL,
	[usdebit] [bit] NULL,
	[ussuspend] [bit] NULL,
	[actallow] [text] NULL,
	[openallow] [bit] NULL,
	[cstallow] [text] NULL,
	[editothers] [bit] NULL,
	[suspend] [bit] NULL,
	[usalwchgprs] [bit] NULL,
	[dsplyothers] [bit] NULL,
	[chgperiod] [bit] NULL,
	[chgtdate] [bit] NULL,
	[alwprntrpt] [bit] NULL,
	[printinv] [bit] NULL,
	[printtrx] [bit] NULL,
	[printbarcode] [bit] NULL,
	[onlinepost] [bit] NULL,
	[showitmcst] [bit] NULL,
	[usmagnetic] [bit] NULL,
	[sendsms] [bit] NULL,
	[usslprofit] [bit] NULL,
	[posuser] [bit] NULL,
	[inv_form_no] [numeric](2, 0) NULL,
	[ushide_jv] [bit] NULL,
	[uschdlcshinv] [bit] NULL,
	[uschdlcshrcv] [bit] NULL,
	[uschdlchqrcv] [bit] NULL,
	[usshowprofit] [bit] NULL,
	[goblwmnmp] [bit] NULL,
	[usfpalw] [bit] NULL,
	[usfpimage] [text] NULL,
	[mobileuser] [bit] NULL,
	[confirmPurchase] [bit] NULL,
	[noovrdrft] [bit] NULL,
	[onlyactrmt] [bit] NULL,
	[confirmbr] [bit] NULL,
	[passwordPDA] [varbinary](200) NULL,
	[confirmtrnsfr] [bit] NULL,
	[nopriceblwcost] [bit] NULL,
	[mgmtcnfrm] [bit] NULL,
	[mobilNo] [nvarchar](30) NULL,
	[OTP] [int] NULL,
	[web_rights] [nvarchar](254) NULL,
	[NorgstrNoSl] [bit] NULL,
	[ussctnalw] [text] NULL,
	[Noslsblwcst] [bit] NULL,
	[AlwChangeVAT] [bit] NULL,
	[emp_code] [char](10) NULL,
	[blkassmbld] [bit] NULL,
	[usfpimage2] [text] NULL,
	[max_inv_printed] [numeric](2, 0) NULL,
	[max_fsh_printed] [numeric](2, 0) NULL,
	[usissrqst] [bit] NULL,
	[usstiss] [bit] NULL,
	[usstrcv] [bit] NULL,
	[e_invrdy] [bit] NULL,
	[smartsearch] [bit] NULL,
	[e_password] [varbinary](200) NULL,
	[applymnmallprices] [bit] NULL,
	[smartsrch_itemBaltype] [numeric](1, 0) NULL,
	[puinv_cost_notalwd] [bit] NULL,
	[mnmppalw] [numeric](5, 2) NULL,
	[nopostslinv] [bit] NULL,
	[nopostpuinv] [bit] NULL,
	[nopoststtrx] [bit] NULL,
	[nochgmaxlmt] [bit] NULL,
	[no_item_duplicate] [bit] NULL,
	[no_item_srch_in_puinv] [bit] NULL,
	[alwsend_doc] [bit] NULL,
	[alwslfrmslnobal] [bit] NULL,
	[nochngpromo] [bit] NULL,
	[dsplyothersQH] [bit] NULL,
	[hideqhinfo] [bit] NULL,
	[alwchg_slrtn_price] [bit] NULL,
	[noadd_crdt_clnt] [bit] NULL,
	[archv_upload] [bit] NULL,
	[archv_download] [bit] NULL,
	[archv_open] [bit] NULL,
	[archv_delete] [bit] NULL,
	[alw2usewtsapp] [bit] NULL,
	[alw2chgwtsmbl] [bit] NULL,
	[smrtsrch4cmbkey] [bit] NULL,
	[use_dashboard] [bit] NULL,
 CONSTRAINT [PK_sysuse] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttkfile]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttkfile](
	[fname] [varchar](45) NOT NULL,
	[whno] [char](2) NOT NULL,
	[binno] [char](6) NOT NULL,
	[ttqty] [float] NULL,
	[ttstatus] [numeric](1, 0) NOT NULL,
	[srl_no] [numeric](8, 0) NOT NULL,
	[mclass] [char](12) NULL,
	[itemno] [char](16) NOT NULL,
	[unicode] [char](6) NOT NULL,
	[mqty] [float] NULL,
	[expdate] [char](8) NULL,
	[lcost] [float] NOT NULL,
	[fcost] [float] NULL,
	[barcode] [char](20) NOT NULL,
	[cmbkey] [char](24) NOT NULL,
	[pack0] [char](1) NULL,
	[pkqty1] [numeric](12, 3) NULL,
	[pack1] [char](1) NULL,
	[nobin] [bit] NULL,
 CONSTRAINT [PK_ttkfile] PRIMARY KEY CLUSTERED 
(
	[whno] ASC,
	[binno] ASC,
	[itemno] ASC,
	[unicode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ttkhdr]    Script Date: 2025-11-15 11:43:19 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ttkhdr](
	[ttwhno] [char](2) NOT NULL,
	[ttdate] [char](8) NOT NULL,
	[ttcntr] [numeric](7, 0) NOT NULL,
	[ttcomp] [char](2) NOT NULL,
	[ttsection] [bit] NOT NULL,
	[ttkmanual] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[apclass] ADD  CONSTRAINT [DF_apclass_rowguid]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[apdtl] ADD  CONSTRAINT [DF_apdtl_rplct_post]  DEFAULT ((0)) FOR [rplct_post]
GO
ALTER TABLE [dbo].[apdtl] ADD  CONSTRAINT [DF_apdtl_rowguid]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[aphdr] ADD  CONSTRAINT [DF_aphdr_rowguid]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[aphdr] ADD  DEFAULT ('') FOR [bankref]
GO
ALTER TABLE [dbo].[ardtl] ADD  CONSTRAINT [DF_ardtl_rplct_post]  DEFAULT ((0)) FOR [rplct_post]
GO
ALTER TABLE [dbo].[arhdr] ADD  DEFAULT ((0)) FOR [discountedBill]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ('') FOR [clnt_taxcode]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ((0)) FOR [taxFree]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ('') FOR [cu_kind]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ((0)) FOR [ok_free]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ((0)) FOR [ok_no_pay]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ((0)) FOR [ok_no_down_payment]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ((0)) FOR [exduplimit]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ((0)) FOR [individual_clnt]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ((0)) FOR [cu_invdsc]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ('') FOR [slcode]
GO
ALTER TABLE [dbo].[customer] ADD  DEFAULT ((0)) FOR [lst_inv_excd_duedate]
GO
ALTER TABLE [dbo].[customer_ei] ADD  DEFAULT ('') FOR [Other_Scheme_Type]
GO
ALTER TABLE [dbo].[customer_ei] ADD  DEFAULT ('') FOR [client_name]
GO
ALTER TABLE [dbo].[customer_ei] ADD  DEFAULT ('') FOR [client_mobile]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glcurbal]  DEFAULT ((0)) FOR [glcurbal]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glopnbal]  DEFAULT ((0)) FOR [glopnbal]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal01]  DEFAULT ((0)) FOR [glbal01]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal02]  DEFAULT ((0)) FOR [glbal02]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal03]  DEFAULT ((0)) FOR [glbal03]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal04]  DEFAULT ((0)) FOR [glbal04]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal05]  DEFAULT ((0)) FOR [glbal05]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal06]  DEFAULT ((0)) FOR [glbal06]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal07]  DEFAULT ((0)) FOR [glbal07]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal08]  DEFAULT ((0)) FOR [glbal08]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal09]  DEFAULT ((0)) FOR [glbal09]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal10]  DEFAULT ((0)) FOR [glbal10]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal11]  DEFAULT ((0)) FOR [glbal11]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal12]  DEFAULT ((0)) FOR [glbal12]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glbal13]  DEFAULT ((0)) FOR [glbal13]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fccurbal]  DEFAULT ((0)) FOR [fccurbal]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcopnbal]  DEFAULT ((0)) FOR [fcopnbal]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal01]  DEFAULT ((0)) FOR [fcbal01]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal02]  DEFAULT ((0)) FOR [fcbal02]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal03]  DEFAULT ((0)) FOR [fcbal03]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal04]  DEFAULT ((0)) FOR [fcbal04]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal05]  DEFAULT ((0)) FOR [fcbal05]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal06]  DEFAULT ((0)) FOR [fcbal06]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal07]  DEFAULT ((0)) FOR [fcbal07]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal08]  DEFAULT ((0)) FOR [fcbal08]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal09]  DEFAULT ((0)) FOR [fcbal09]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal10]  DEFAULT ((0)) FOR [fcbal10]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal11]  DEFAULT ((0)) FOR [fcbal11]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal12]  DEFAULT ((0)) FOR [fcbal12]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_fcbal13]  DEFAULT ((0)) FOR [fcbal13]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_imopnbal]  DEFAULT ((0)) FOR [imopnbal]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_imcurbal]  DEFAULT ((0)) FOR [imcurbal]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_pkey]  DEFAULT ((0)) FOR [pkey]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_chkey]  DEFAULT ((0)) FOR [chkey]
GO
ALTER TABLE [dbo].[glchart] ADD  CONSTRAINT [DF_glchart_glackind]  DEFAULT ('0') FOR [glackind]
GO
ALTER TABLE [dbo].[glcstctr] ADD  CONSTRAINT [DF_glcstctr_rowguid]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[glcstctr] ADD  DEFAULT ((0)) FOR [xpercent]
GO
ALTER TABLE [dbo].[glcurr] ADD  DEFAULT ((0)) FOR [curminrate]
GO
ALTER TABLE [dbo].[glcurr] ADD  DEFAULT ((0)) FOR [curmaxrate]
GO
ALTER TABLE [dbo].[glcurr] ADD  DEFAULT ('') FOR [standard_fcy_code]
GO
ALTER TABLE [dbo].[gljrcost] ADD  CONSTRAINT [DF_gljrcost_rplct_post]  DEFAULT ((0)) FOR [rplct_post]
GO
ALTER TABLE [dbo].[gljrdtl] ADD  CONSTRAINT [DF_gljrdtl_rplct_post]  DEFAULT ((0)) FOR [rplct_post]
GO
ALTER TABLE [dbo].[gljrdtl] ADD  CONSTRAINT [DF_gljrdtl_rowguid]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[gljrdtl] ADD  DEFAULT ((0)) FOR [taxcatId]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  CONSTRAINT [DF_gljrhdr_jhcomp]  DEFAULT ((0)) FOR [jhcomp]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  CONSTRAINT [DF_gljrhdr_jhlccrttl]  DEFAULT ((0)) FOR [jhlccrttl]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  CONSTRAINT [DF_gljrhdr_jhlcdbttl]  DEFAULT ((0)) FOR [jhlcdbttl]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  CONSTRAINT [DF_gljrhdr_jhfccrttl]  DEFAULT ((0)) FOR [jhfccrttl]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  CONSTRAINT [DF_gljrhdr_jhfcdbttl]  DEFAULT ((0)) FOR [jhfcdbttl]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  CONSTRAINT [DF_gljrhdr_jhimgrate]  DEFAULT ((0)) FOR [jhimgrate]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  CONSTRAINT [DF_gljrhdr_hide_jv]  DEFAULT ((0)) FOR [hide_jv]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  CONSTRAINT [DF_gljrhdr_rowguid]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  DEFAULT ('') FOR [bankref]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  DEFAULT ((0)) FOR [Vat_Percent]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  DEFAULT ('') FOR [jhtext1]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  DEFAULT ('') FOR [sc_codeyrtp]
GO
ALTER TABLE [dbo].[gljrhdr] ADD  DEFAULT ((0)) FOR [zatca_rounding]
GO
ALTER TABLE [dbo].[glsction] ADD  CONSTRAINT [DF_glsction_sc_nowh]  DEFAULT ((1)) FOR [sc_nowh]
GO
ALTER TABLE [dbo].[glsction] ADD  CONSTRAINT [DF_glsction_sc_m_center]  DEFAULT ((0)) FOR [sc_m_center]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_01]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_02]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_03]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_04]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_05]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_06]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_07]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_08]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_09]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_10]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_11]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_12]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_13]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_14]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_18]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_19]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_20]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_21]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_22]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_23]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_24]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_26]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_27]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_28]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_30]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_31]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_32]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_33]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_34]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_45]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_46]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_16]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_17]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [sysno]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [No_round_nm]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [PriceVatType]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [mkt_frc_rounding]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [is_dsc_amt]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [auto_dsc_hll]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [max_dsc_hll]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [sc_card_srlno]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [sc_card_jvno]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ('') FOR [ar_dscser]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ('') FOR [ap_dscser]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [sc_lvlno]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ('') FOR [cashser]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [crdt_limit]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ('') FOR [sc_lvl1]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ('') FOR [sc_lvl2]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ('') FOR [sc_lvl3]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [CHKEY]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [PKEY]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_start_year_serial]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ('') FOR [sc_fxdpart]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((0)) FOR [jv_301]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_60]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_61]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_105]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_106]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_107]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_108]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_109]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_110]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_205]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_209]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_210]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_211]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_212]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_213]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_214]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_215]
GO
ALTER TABLE [dbo].[glsction] ADD  DEFAULT ((1)) FOR [jv_216]
GO
ALTER TABLE [dbo].[jccstord_hdr] ADD  DEFAULT ('') FOR [slcode]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expentries1]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expttlhours1]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expttlcost1]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expentries2]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expttlhours2]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expttlcost2]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expentries3]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expttlhours3]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expttlcost3]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ('') FOR [fcy]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [fcyrate]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_ttlcost_fcy]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expttlcost_fcy]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_matttlcost_fcy]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_untcost_fcy]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expttlcost1_fcy]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expttlcost2_fcy]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ((0)) FOR [ch_expttlcost3_fcy]
GO
ALTER TABLE [dbo].[jchdr] ADD  DEFAULT ('') FOR [section]
GO
ALTER TABLE [dbo].[jcmatdtl] ADD  DEFAULT ((0)) FOR [fcost]
GO
ALTER TABLE [dbo].[jcresources] ADD  DEFAULT ((1)) FOR [rs_level]
GO
ALTER TABLE [dbo].[jcrsrsdtl] ADD  DEFAULT ((0)) FOR [rd_hourcost_fcy]
GO
ALTER TABLE [dbo].[jcsetup] ADD  CONSTRAINT [DF__jcsetup__jc_addm__63E3BB6D]  DEFAULT ((0)) FOR [jc_addmatitm]
GO
ALTER TABLE [dbo].[jcsetup] ADD  CONSTRAINT [DF__jcsetup__jc_chgm__51C50B32]  DEFAULT ((0)) FOR [jc_chgmatqty]
GO
ALTER TABLE [dbo].[jcsetup] ADD  CONSTRAINT [DF__jcsetup__jc_chgw__52B92F6B]  DEFAULT ((0)) FOR [jc_chgwsptg]
GO
ALTER TABLE [dbo].[jcsetup] ADD  CONSTRAINT [DF__jcsetup__jc_usef__53AD53A4]  DEFAULT ((0)) FOR [jc_usefnlwste]
GO
ALTER TABLE [dbo].[jcsetup] ADD  DEFAULT ((0)) FOR [jc_seplocprdday]
GO
ALTER TABLE [dbo].[jcsetup] ADD  DEFAULT ((0)) FOR [jc_resources_cost_is_fcy]
GO
ALTER TABLE [dbo].[jcsetup] ADD  DEFAULT ('') FOR [brnno]
GO
ALTER TABLE [dbo].[jcsetup] ADD  DEFAULT ('') FOR [sc_code]
GO
ALTER TABLE [dbo].[jcstitems] ADD  DEFAULT ((0)) FOR [days_to_exp_fm_prod]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  CONSTRAINT [DF_ord_dtl_fqty]  DEFAULT ((0)) FOR [fqty]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ((0)) FOR [folio]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ('') FOR [splyinv]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ('') FOR [dlvrydate]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ('') FOR [caser]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ((0)) FOR [brqty3]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ((0)) FOR [brqty4]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT (' ') FOR [shadd]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ((0)) FOR [shdqty]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ((0)) FOR [frtqty]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ((1)) FOR [Taxtype]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ('') FOR [remarks]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ((0)) FOR [item_bal]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ('') FOR [mnpack0]
GO
ALTER TABLE [dbo].[ord_dtl] ADD  DEFAULT ((0)) FOR [last_ord_cost]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  CONSTRAINT [DF_ord_hdr_rcvdtrn]  DEFAULT ((0)) FOR [rcvdtrn]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  CONSTRAINT [df_ord_hdr_usrid]  DEFAULT ('') FOR [usrid]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  DEFAULT ((0)) FOR [vat_amt_paid]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  DEFAULT ((0)) FOR [PriceIncludeVat]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  DEFAULT ((0)) FOR [taxfree_purchase]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  DEFAULT ((0)) FOR [fqtyval]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  DEFAULT ('') FOR [dlvry_date]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  DEFAULT ((0)) FOR [tdscpcs]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  DEFAULT ((0)) FOR [tdscdays]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  DEFAULT ('') FOR [slcenter]
GO
ALTER TABLE [dbo].[ord_hdr] ADD  DEFAULT ('') FOR [slcode]
GO
ALTER TABLE [dbo].[orpacking] ADD  DEFAULT ((0)) FOR [pkwhlsl]
GO
ALTER TABLE [dbo].[orpacking] ADD  DEFAULT ('') FOR [standard_unit_code]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ('') FOR [vat_paid_act]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [chk_serfrt]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [chk_serins]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [chk_sercst]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [chk_serpvl]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [chk_sersmp]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [chk_serfn]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [chk_sertkt]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [chk_serfre]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [chk_sertrn]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [chk_seroth]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ((0)) FOR [suspended]
GO
ALTER TABLE [dbo].[pudept] ADD  DEFAULT ('') FOR [servndr]
GO
ALTER TABLE [dbo].[pudtl] ADD  CONSTRAINT [DF_pudtl_folio]  DEFAULT ((0)) FOR [folio]
GO
ALTER TABLE [dbo].[pudtl] ADD  CONSTRAINT [DF_pudtl_rplct_post]  DEFAULT ((0)) FOR [rplct_post]
GO
ALTER TABLE [dbo].[pudtl] ADD  DEFAULT ('') FOR [whno]
GO
ALTER TABLE [dbo].[pudtl] ADD  DEFAULT ('') FOR [splyinv]
GO
ALTER TABLE [dbo].[pudtl] ADD  DEFAULT ((0)) FOR [edm_value]
GO
ALTER TABLE [dbo].[pudtl] ADD  DEFAULT ((0)) FOR [garntee_amt]
GO
ALTER TABLE [dbo].[pudtl] ADD  DEFAULT ((1)) FOR [Taxtype]
GO
ALTER TABLE [dbo].[pudtl] ADD  DEFAULT ((0)) FOR [item_vat]
GO
ALTER TABLE [dbo].[pudtl] ADD  DEFAULT ((0)) FOR [item_price_net]
GO
ALTER TABLE [dbo].[pudtl] ADD  DEFAULT ((0)) FOR [item_fq_vat]
GO
ALTER TABLE [dbo].[pudtl] ADD  DEFAULT ((0)) FOR [invdscamt]
GO
ALTER TABLE [dbo].[pudtl] ADD  DEFAULT ((0)) FOR [dsc_amt]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ('') FOR [shpdate]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((1)) FOR [edm]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [gntd_fm_lc]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0.00)) FOR [lc_ship_no]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [xfr_amt]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ('') FOR [xfr_acc]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [vat_amt_paid]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [taxfree_purchase]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [VatNot4Vender]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ('') FOR [vndr_taxcode]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [expns4vat]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ('') FOR [tax_Pd_mthd]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ('') FOR [vndr_kind]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [manulvat]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [dscamt_type]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [hlldscnt]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [PriceIncludeVat]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [vat_percent]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [fqtyval]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [chng_item_price]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [zatca_rounding]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [unincld_vndr_expns]
GO
ALTER TABLE [dbo].[puhdr] ADD  DEFAULT ((0)) FOR [is_pu_dsc_amt]
GO
ALTER TABLE [dbo].[salecntr] ADD  CONSTRAINT [DF_salecntr_no_of_invCopies]  DEFAULT ((1)) FOR [no_of_invCopies]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [vat_rcvd_act]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [stcpay_act]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ((0)) FOR [suspended]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [qitaf_act]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [slscmnact]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [webcmnact]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [tprtexpact]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [bldg_no]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [bldg_no_l]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [street_name]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [street_name_l]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [area_name]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [area_name_l]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [extra_address_no]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [extra_address_no_l]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [district]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [district_l]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [city_text]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [city_text_l]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [street_name2]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [street_name2_l]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [postal_code]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [Other_id_SchemeID]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [Group_VAT_ID]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ((0)) FOR [country_code]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [Other_Scheme_Type]
GO
ALTER TABLE [dbo].[salecntr] ADD  DEFAULT ('') FOR [manafith_api]
GO
ALTER TABLE [dbo].[sales_dd] ADD  CONSTRAINT [DF_sales_dd_rplct_post]  DEFAULT ((0)) FOR [rplct_post]
GO
ALTER TABLE [dbo].[sales_dd] ADD  CONSTRAINT [DF_sales_dd_folio]  DEFAULT ((0)) FOR [folio]
GO
ALTER TABLE [dbo].[sales_dd] ADD  DEFAULT ('') FOR [whqty]
GO
ALTER TABLE [dbo].[sales_dd] ADD  DEFAULT ((0)) FOR [nprice2]
GO
ALTER TABLE [dbo].[sales_dd] ADD  DEFAULT ((0)) FOR [nprice3]
GO
ALTER TABLE [dbo].[sales_dd] ADD  DEFAULT ('') FOR [jvtype]
GO
ALTER TABLE [dbo].[sales_dd] ADD  DEFAULT ((0)) FOR [jvref]
GO
ALTER TABLE [dbo].[sales_dd] ADD  DEFAULT ('') FOR [taxtype]
GO
ALTER TABLE [dbo].[sales_dd] ADD  DEFAULT ((0)) FOR [item_vat]
GO
ALTER TABLE [dbo].[sales_dd] ADD  DEFAULT ((0)) FOR [item_price_net]
GO
ALTER TABLE [dbo].[sales_dd] ADD  DEFAULT ('') FOR [dscpack]
GO
ALTER TABLE [dbo].[sales_dd] ADD  DEFAULT ((0)) FOR [avgcost]
GO
ALTER TABLE [dbo].[sales_dh] ADD  CONSTRAINT [DF_sales_hs_posinv]  DEFAULT ((0)) FOR [posinv]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ((0)) FOR [vat_amt_rcvd]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ((0)) FOR [taxfree_sales]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ((1)) FOR [PriceVatType]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ((0)) FOR [vat_percent]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ('') FOR [clnt_taxcode]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ('') FOR [clnt_kind]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ('') FOR [jvtype]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ((0)) FOR [jvref]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ('') FOR [yrcode]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ((0)) FOR [zatca_rounding]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ((0)) FOR [dsc4allqty]
GO
ALTER TABLE [dbo].[sales_dh] ADD  DEFAULT ('') FOR [invoicelist]
GO
ALTER TABLE [dbo].[sales_dt] ADD  CONSTRAINT [DF_sales_dt_discpc]  DEFAULT ((0)) FOR [discpc]
GO
ALTER TABLE [dbo].[sales_dt] ADD  CONSTRAINT [DF_sales_dt_folio]  DEFAULT ((0)) FOR [folio]
GO
ALTER TABLE [dbo].[sales_dt] ADD  CONSTRAINT [DF_sales_dt_rplct_post]  DEFAULT ((0)) FOR [rplct_post]
GO
ALTER TABLE [dbo].[sales_dt] ADD  DEFAULT ((0)) FOR [sold_item_status]
GO
ALTER TABLE [dbo].[sales_dt] ADD  DEFAULT ((1)) FOR [Taxtype]
GO
ALTER TABLE [dbo].[sales_dt] ADD  DEFAULT ((0)) FOR [ps_item_vat]
GO
ALTER TABLE [dbo].[sales_dt] ADD  DEFAULT ((0)) FOR [dsc_amt]
GO
ALTER TABLE [dbo].[sales_dt] ADD  DEFAULT (' ') FOR [binno]
GO
ALTER TABLE [dbo].[sales_dt] ADD  DEFAULT ((0)) FOR [item_price_net]
GO
ALTER TABLE [dbo].[sales_dt] ADD  DEFAULT ((0)) FOR [invdscamt]
GO
ALTER TABLE [dbo].[sales_dt] ADD  DEFAULT ((0)) FOR [item_fq_vat]
GO
ALTER TABLE [dbo].[sales_dt] ADD  DEFAULT ((0)) FOR [item_vat]
GO
ALTER TABLE [dbo].[sales_dt] ADD  DEFAULT ((0)) FOR [m_sl_ref]
GO
ALTER TABLE [dbo].[sales_ei] ADD  CONSTRAINT [DF_sales_ei_uuid]  DEFAULT (newid()) FOR [uuid]
GO
ALTER TABLE [dbo].[sales_ei] ADD  CONSTRAINT [DF__sales_ei__usr_sl__469D7149]  DEFAULT ((0)) FOR [usr_slct_simple_einv]
GO
ALTER TABLE [dbo].[sales_ei] ADD  CONSTRAINT [DF__sales_ei__invoic__56DEC60A]  DEFAULT ((0)) FOR [invoice_charges]
GO
ALTER TABLE [dbo].[sales_ei] ADD  CONSTRAINT [DF__sales_ei__Exempt__61081A19]  DEFAULT ('') FOR [ExemptionReason]
GO
ALTER TABLE [dbo].[sales_ei] ADD  CONSTRAINT [DF__sales_ei__EXEMPT__0BBD6DF4]  DEFAULT ('') FOR [Exemptioncode]
GO
ALTER TABLE [dbo].[sales_ei] ADD  CONSTRAINT [DF__sales_ei__zatca___0DA5B666]  DEFAULT ('') FOR [zatca_datetime]
GO
ALTER TABLE [dbo].[sales_ei] ADD  CONSTRAINT [DF__sales_ei__is_pro__46DE33C2]  DEFAULT ((0)) FOR [is_production]
GO
ALTER TABLE [dbo].[sales_hd] ADD  CONSTRAINT [DF_sales_hd_posinv]  DEFAULT ((0)) FOR [posinv]
GO
ALTER TABLE [dbo].[sales_hd] ADD  CONSTRAINT [DF_sales_hd_saned_amt]  DEFAULT ((0)) FOR [sanedcrd_amt]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ('') FOR [remarks]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ('') FOR [remarks2]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [invlocked]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0.00)) FOR [rtncash_dfrpl]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [vat_amt_rcvd]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [taxfree_sales]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ('') FOR [clnt_taxcode]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ('') FOR [clnt_kind]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [hlldscnt]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((1)) FOR [sysno]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [No_round_nm]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((1)) FOR [PriceVatType]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [smssent]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [stcpay_amt]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [fc2lcamt]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [qitaf_amt]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [whlslinv]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [vat_percent]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [fsh_printed]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [fqtyval]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [discountedBill]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ('') FOR [Fusrprintinv]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [almnm_contract_section]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [instlmnt_code]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [installment_amt]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ('') FOR [mobileNo]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ('') FOR [client_name]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [cashpaid]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [zatca_rounding]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [multi_refund_inv]
GO
ALTER TABLE [dbo].[sales_hd] ADD  DEFAULT ((0)) FOR [refund_no_inv_avl]
GO
ALTER TABLE [dbo].[sales_od] ADD  CONSTRAINT [DF_sales_od_folio]  DEFAULT ((0)) FOR [folio]
GO
ALTER TABLE [dbo].[sales_od] ADD  DEFAULT ('1') FOR [taxtype]
GO
ALTER TABLE [dbo].[sales_od] ADD  DEFAULT ((0)) FOR [item_vat]
GO
ALTER TABLE [dbo].[sales_od] ADD  DEFAULT ((0)) FOR [item_price_net]
GO
ALTER TABLE [dbo].[sales_od] ADD  DEFAULT ((0)) FOR [item_fq_vat]
GO
ALTER TABLE [dbo].[sales_od] ADD  DEFAULT ((0)) FOR [invdscamt]
GO
ALTER TABLE [dbo].[sales_oh] ADD  DEFAULT ((0)) FOR [vat_amt_rcvd]
GO
ALTER TABLE [dbo].[sales_oh] ADD  DEFAULT ((0)) FOR [taxfree_sales]
GO
ALTER TABLE [dbo].[sales_oh] ADD  DEFAULT ('') FOR [clnt_taxcode]
GO
ALTER TABLE [dbo].[sales_oh] ADD  DEFAULT ('') FOR [clnt_kind]
GO
ALTER TABLE [dbo].[sales_oh] ADD  DEFAULT ((0)) FOR [wh_rsvqty]
GO
ALTER TABLE [dbo].[sales_oh] ADD  DEFAULT ((0)) FOR [zatca_rounding]
GO
ALTER TABLE [dbo].[sales_oh] ADD  DEFAULT ((0)) FOR [vat_percent]
GO
ALTER TABLE [dbo].[sales_oh] ADD  DEFAULT ((0)) FOR [pricevattype]
GO
ALTER TABLE [dbo].[sales_qd] ADD  DEFAULT ((0)) FOR [folio]
GO
ALTER TABLE [dbo].[sales_qd] ADD  DEFAULT ('') FOR [whno]
GO
ALTER TABLE [dbo].[sales_qd] ADD  DEFAULT ((0)) FOR [item_Quoted]
GO
ALTER TABLE [dbo].[sales_qd] ADD  DEFAULT ((0)) FOR [dsc_amt]
GO
ALTER TABLE [dbo].[sales_qd] ADD  DEFAULT ((0)) FOR [item_vat]
GO
ALTER TABLE [dbo].[sales_qd] ADD  DEFAULT ((0)) FOR [item_price_net]
GO
ALTER TABLE [dbo].[sales_qd] ADD  DEFAULT ((0)) FOR [item_fq_vat]
GO
ALTER TABLE [dbo].[sales_qd] ADD  DEFAULT ((0)) FOR [invdscamt]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ('') FOR [usrid]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ((0)) FOR [vat_amt_rcvd]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ((0)) FOR [taxfree_sales]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ('') FOR [clnt_taxcode]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ('') FOR [clnt_kind]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ('') FOR [qhtype]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ('') FOR [qhstatus]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ('') FOR [newcstmrname]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ('') FOR [newcstmrcntct]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ('') FOR [cstmrmobile]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ((0)) FOR [fqtyval]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ((0)) FOR [zatca_rounding]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ((0)) FOR [vat_percent]
GO
ALTER TABLE [dbo].[sales_qh] ADD  DEFAULT ((0)) FOR [pricevattype]
GO
ALTER TABLE [dbo].[salesmen] ADD  CONSTRAINT [DF_salesmen_notify_type]  DEFAULT ((0)) FOR [notify_type]
GO
ALTER TABLE [dbo].[salesmen] ADD  CONSTRAINT [DF_salesmen_notify_within]  DEFAULT ((30)) FOR [notify_within]
GO
ALTER TABLE [dbo].[salesmen] ADD  DEFAULT ('') FOR [slscmnact]
GO
ALTER TABLE [dbo].[salesmen] ADD  DEFAULT ((0)) FOR [crdt_limit]
GO
ALTER TABLE [dbo].[salesmen] ADD  DEFAULT ('') FOR [sl_center]
GO
ALTER TABLE [dbo].[sdaad_dt] ADD  DEFAULT ((0)) FOR [vat_amt_paid]
GO
ALTER TABLE [dbo].[sdaad_hd] ADD  CONSTRAINT [DF_sdaad_hd_rcvdtrn]  DEFAULT ((0)) FOR [rcvdtrn]
GO
ALTER TABLE [dbo].[sdaad_hd] ADD  DEFAULT ((0)) FOR [Vat_Percent]
GO
ALTER TABLE [dbo].[sdaad_hd] ADD  DEFAULT ((0)) FOR [sdttlvatamt]
GO
ALTER TABLE [dbo].[sdaad_hd] ADD  DEFAULT ((0)) FOR [vat_included]
GO
ALTER TABLE [dbo].[sdaad_hd] ADD  DEFAULT ((0)) FOR [sdNoVat]
GO
ALTER TABLE [dbo].[sddtl] ADD  CONSTRAINT [DF_sddtl_rplct_post]  DEFAULT ((0)) FOR [rplct_post]
GO
ALTER TABLE [dbo].[sddtl] ADD  CONSTRAINT [DF_sddtl_rowguid]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[sddtl] ADD  DEFAULT ((0)) FOR [taxcatId]
GO
ALTER TABLE [dbo].[sddtl] ADD  DEFAULT ((0)) FOR [jdcstval]
GO
ALTER TABLE [dbo].[sddtl] ADD  DEFAULT ('') FOR [cstkey]
GO
ALTER TABLE [dbo].[sddtl] ADD  DEFAULT ('') FOR [vndr_taxcode]
GO
ALTER TABLE [dbo].[sddtl] ADD  DEFAULT ('') FOR [vndr_name]
GO
ALTER TABLE [dbo].[sddtl] ADD  DEFAULT ((0)) FOR [no_chng_col]
GO
ALTER TABLE [dbo].[sddtl] ADD  DEFAULT ((0)) FOR [amtincldvat]
GO
ALTER TABLE [dbo].[sdhdr] ADD  CONSTRAINT [DF_sdhdr_rowguid]  DEFAULT (newsequentialid()) FOR [rowguid]
GO
ALTER TABLE [dbo].[sdhdr] ADD  DEFAULT ((0)) FOR [Vat_Percent]
GO
ALTER TABLE [dbo].[sdhdr] ADD  DEFAULT ((0)) FOR [serial_no]
GO
ALTER TABLE [dbo].[sdhdr] ADD  DEFAULT ('') FOR [brxfrm]
GO
ALTER TABLE [dbo].[sdhdr] ADD  DEFAULT ('') FOR [caser]
GO
ALTER TABLE [dbo].[sdhdr] ADD  DEFAULT ((0)) FOR [ctype]
GO
ALTER TABLE [dbo].[sdhdr] ADD  DEFAULT ('') FOR [clnt_kind]
GO
ALTER TABLE [dbo].[sdhdr] ADD  DEFAULT ((0)) FOR [hide_jv]
GO
ALTER TABLE [dbo].[slglsscc] ADD  DEFAULT ((0)) FOR [is_tax_applied]
GO
ALTER TABLE [dbo].[stbins] ADD  CONSTRAINT [DF_stbins_lcost]  DEFAULT ((0)) FOR [lcost]
GO
ALTER TABLE [dbo].[stbins] ADD  CONSTRAINT [DF_stbins_fcost]  DEFAULT ((0)) FOR [fcost]
GO
ALTER TABLE [dbo].[stbins] ADD  CONSTRAINT [DF_stbins_openlcost]  DEFAULT ((0)) FOR [openlcost]
GO
ALTER TABLE [dbo].[stbins] ADD  CONSTRAINT [DF_stbins_openfcost]  DEFAULT ((0)) FOR [openfcost]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_bcserial]  DEFAULT ((0)) FOR [bcserial]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_01]  DEFAULT ((0)) FOR [jv_01]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_02]  DEFAULT ((0)) FOR [jv_02]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_03]  DEFAULT ((0)) FOR [jv_03]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_04]  DEFAULT ((0)) FOR [jv_04]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_05]  DEFAULT ((0)) FOR [jv_05]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_06]  DEFAULT ((0)) FOR [jv_06]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_07]  DEFAULT ((0)) FOR [jv_07]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_08]  DEFAULT ((0)) FOR [jv_08]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_09]  DEFAULT ((0)) FOR [jv_09]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_10]  DEFAULT ((0)) FOR [jv_10]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_11]  DEFAULT ((0)) FOR [jv_11]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_12]  DEFAULT ((0)) FOR [jv_12]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_13]  DEFAULT ((0)) FOR [jv_13]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_14]  DEFAULT ((0)) FOR [jv_14]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_18]  DEFAULT ((0)) FOR [jv_18]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_19]  DEFAULT ((0)) FOR [jv_19]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_20]  DEFAULT ((0)) FOR [jv_20]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_21]  DEFAULT ((0)) FOR [jv_21]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_22]  DEFAULT ((0)) FOR [jv_22]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_23]  DEFAULT ((0)) FOR [jv_23]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_24]  DEFAULT ((0)) FOR [jv_24]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_26]  DEFAULT ((0)) FOR [jv_26]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_27]  DEFAULT ((0)) FOR [jv_27]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_28]  DEFAULT ((0)) FOR [jv_28]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_30]  DEFAULT ((0)) FOR [jv_30]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_31]  DEFAULT ((0)) FOR [jv_31]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_32]  DEFAULT ((0)) FOR [jv_32]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_33]  DEFAULT ((0)) FOR [jv_33]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_34]  DEFAULT ((0)) FOR [jv_34]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_calgl]  DEFAULT ((1)) FOR [calgl]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_calar]  DEFAULT ((1)) FOR [calar]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_calap]  DEFAULT ((1)) FOR [calap]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_calst]  DEFAULT ((1)) FOR [calst]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_45]  DEFAULT ((0)) FOR [jv_45]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_17]  DEFAULT ((0)) FOR [jv_17]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_16]  DEFAULT ((0)) FOR [jv_16]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_46]  DEFAULT ((0)) FOR [jv_46]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_jv_101]  DEFAULT ((0)) FOR [jv_101]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF_stbranch_manualser]  DEFAULT ((0)) FOR [manualser]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__fm_pri__7CC477D0]  DEFAULT ((0)) FOR [fm_price1]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__to_pri__7DB89C09]  DEFAULT ((0)) FOR [to_price1]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__doz_pr__7EACC042]  DEFAULT ((0)) FOR [doz_price1]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__ctn_pr__7FA0E47B]  DEFAULT ((0)) FOR [ctn_price1]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__fm_pri__009508B4]  DEFAULT ((0)) FOR [fm_price2]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__to_pri__01892CED]  DEFAULT ((0)) FOR [to_price2]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__doz_pr__027D5126]  DEFAULT ((0)) FOR [doz_price2]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__ctn_pr__0371755F]  DEFAULT ((0)) FOR [ctn_price2]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__fm_pri__04659998]  DEFAULT ((0)) FOR [fm_price3]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__to_pri__0559BDD1]  DEFAULT ((0)) FOR [to_price3]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__doz_pr__064DE20A]  DEFAULT ((0)) FOR [doz_price3]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__ctn_pr__07420643]  DEFAULT ((0)) FOR [ctn_price3]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__pricet__08362A7C]  DEFAULT ((1)) FOR [pricetp]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__sysno__092A4EB5]  DEFAULT ((1)) FOR [sysno]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__No_rou__0A1E72EE]  DEFAULT ((0)) FOR [No_round_nm]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__PriceV__0B129727]  DEFAULT ((1)) FOR [PriceVatType]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__mkt_fr__0C06BB60]  DEFAULT ((0)) FOR [mkt_frc_rounding]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__is_dsc__0CFADF99]  DEFAULT ((0)) FOR [is_dsc_amt]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__auto_d__0DEF03D2]  DEFAULT ((0)) FOR [auto_dsc_hll]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__max_ds__0EE3280B]  DEFAULT ((0)) FOR [max_dsc_hll]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__pos_ty__0FD74C44]  DEFAULT ((0)) FOR [pos_type]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__jv_51__10CB707D]  DEFAULT ((1)) FOR [jv_51]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__sc_lvl__11BF94B6]  DEFAULT ((1)) FOR [sc_lvlno]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__vat_pa__12B3B8EF]  DEFAULT ('') FOR [vat_paid_act]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__jv_105__13A7DD28]  DEFAULT ((0)) FOR [jv_105]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__jv_106__149C0161]  DEFAULT ((0)) FOR [jv_106]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__jv_107__1590259A]  DEFAULT ((0)) FOR [jv_107]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__jv_108__168449D3]  DEFAULT ((0)) FOR [jv_108]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__jv_109__17786E0C]  DEFAULT ((0)) FOR [jv_109]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__jv_110__186C9245]  DEFAULT ((0)) FOR [jv_110]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__Jv_37__1960B67E]  DEFAULT ((0)) FOR [Jv_37]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__jv_55__1A54DAB7]  DEFAULT ((0)) FOR [jv_55]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__jv_56__1B48FEF0]  DEFAULT ((0)) FOR [jv_56]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__JV_60__1C3D2329]  DEFAULT ((1)) FOR [JV_60]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__JV_61__1D314762]  DEFAULT ((1)) FOR [JV_61]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__distri__1E256B9B]  DEFAULT ('') FOR [district]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__distri__1F198FD4]  DEFAULT ('') FOR [district_l]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__city_t__200DB40D]  DEFAULT ('') FOR [city_text]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__city_t__2101D846]  DEFAULT ('') FOR [city_text_l]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__postal__21F5FC7F]  DEFAULT ('') FOR [postal_code]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__bldg_n__22EA20B8]  DEFAULT ('') FOR [bldg_no]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__bldg_n__23DE44F1]  DEFAULT ('') FOR [bldg_no_l]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__street__24D2692A]  DEFAULT ('') FOR [street_name]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__street__25C68D63]  DEFAULT ('') FOR [street_name_l]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__area_n__26BAB19C]  DEFAULT ('') FOR [area_name]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__area_n__27AED5D5]  DEFAULT ('') FOR [area_name_l]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__extra___28A2FA0E]  DEFAULT ('') FOR [extra_address_no]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__extra___29971E47]  DEFAULT ('') FOR [extra_address_no_l]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__crdt_l__2A8B4280]  DEFAULT ((0)) FOR [crdt_limit]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__Street__2B7F66B9]  DEFAULT ('') FOR [Street_Name2]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__Street__2C738AF2]  DEFAULT ('') FOR [Street_Name2_l]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__Group___2D67AF2B]  DEFAULT ('') FOR [Group_VAT_ID]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__Other___2E5BD364]  DEFAULT ('') FOR [Other_id_SchemeID]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__countr__2F4FF79D]  DEFAULT ((0)) FOR [country_code]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__Other___30441BD6]  DEFAULT ('') FOR [Other_Scheme_Type]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__vat_rc__5D8BC399]  DEFAULT ('') FOR [vat_rcvd_act]
GO
ALTER TABLE [dbo].[stbranch] ADD  CONSTRAINT [DF__stbranch__remote__61B15A38]  DEFAULT ('') FOR [remote_br_sqlserver]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ('') FOR [rvnuact]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ((0)) FOR [jv_301]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ((1)) FOR [jv_205]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ((1)) FOR [jv_209]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ((1)) FOR [jv_210]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ((1)) FOR [jv_211]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ((1)) FOR [jv_212]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ((1)) FOR [jv_213]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ((1)) FOR [jv_214]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ((1)) FOR [jv_215]
GO
ALTER TABLE [dbo].[stbranch] ADD  DEFAULT ((1)) FOR [jv_216]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_slcenter]  DEFAULT ('  ') FOR [slcenter]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_lprice1]  DEFAULT ((0)) FOR [lprice1]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_lprice2]  DEFAULT ((0)) FOR [lprice2]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_lprice3]  DEFAULT ((0)) FOR [lprice3]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_maxdisc1]  DEFAULT ((0)) FOR [maxdisc1]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_maxdisc2]  DEFAULT ((0)) FOR [maxdisc2]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_maxdisc3]  DEFAULT ((0)) FOR [maxdisc3]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_mnmprice]  DEFAULT ((0)) FOR [mnmprice]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_pprice1]  DEFAULT ((0)) FOR [pprice1]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_pprice2]  DEFAULT ((0)) FOR [pprice2]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_pprice3]  DEFAULT ((0)) FOR [pprice3]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_promotion]  DEFAULT ((0)) FOR [promotion]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_slsprsnt]  DEFAULT ((0)) FOR [slsprsnt]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_fprice1]  DEFAULT ((0)) FOR [fprice1]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_fprice2]  DEFAULT ((0)) FOR [fprice2]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_fprice3]  DEFAULT ((0)) FOR [fprice3]
GO
ALTER TABLE [dbo].[stbrprice] ADD  CONSTRAINT [DF_stbrprice_modified]  DEFAULT ((0)) FOR [modified]
GO
ALTER TABLE [dbo].[stclass] ADD  DEFAULT ((0)) FOR [max_sl_limit]
GO
ALTER TABLE [dbo].[stcommission] ADD  CONSTRAINT [DF_stcommission_commtype]  DEFAULT ((1)) FOR [commtype]
GO
ALTER TABLE [dbo].[stcommission] ADD  CONSTRAINT [DF_stcommission_commession]  DEFAULT ((0)) FOR [commission]
GO
ALTER TABLE [dbo].[stcommission] ADD  CONSTRAINT [DF_stcommission_cmtarget]  DEFAULT ((0)) FOR [cmntarget]
GO
ALTER TABLE [dbo].[stcommission] ADD  CONSTRAINT [DF_stcommission_cmnactive]  DEFAULT ((0)) FOR [InActive]
GO
ALTER TABLE [dbo].[stcommission] ADD  CONSTRAINT [DF_stcommission_cmsn_on_qty]  DEFAULT ((0)) FOR [cmsn_onQty]
GO
ALTER TABLE [dbo].[stcommission] ADD  DEFAULT ((0)) FOR [cmsn_calctype]
GO
ALTER TABLE [dbo].[stcommission] ADD  DEFAULT ((0)) FOR [cmsn_perqty]
GO
ALTER TABLE [dbo].[stcommission] ADD  DEFAULT ((0)) FOR [cmsn_payval]
GO
ALTER TABLE [dbo].[stcosttype] ADD  CONSTRAINT [DF_stcosttype_lastlcost]  DEFAULT ((0)) FOR [lastlcost]
GO
ALTER TABLE [dbo].[stcosttype] ADD  CONSTRAINT [DF_stcosttype_highlcost]  DEFAULT ((0)) FOR [highlcost]
GO
ALTER TABLE [dbo].[stcosttype] ADD  CONSTRAINT [DF_stcosttype_lowlcost]  DEFAULT ((0)) FOR [lowlcost]
GO
ALTER TABLE [dbo].[stcosttype] ADD  CONSTRAINT [DF_stcosttype_lastfcost]  DEFAULT ((0)) FOR [lastfcost]
GO
ALTER TABLE [dbo].[stcosttype] ADD  DEFAULT ('') FOR [frstrcvdate]
GO
ALTER TABLE [dbo].[stcosttype] ADD  DEFAULT ('') FOR [frstrcvd01]
GO
ALTER TABLE [dbo].[stcosttype] ADD  DEFAULT ('') FOR [lastrcvd01]
GO
ALTER TABLE [dbo].[stcosttype] ADD  DEFAULT ((0)) FOR [lastlcost01]
GO
ALTER TABLE [dbo].[stcosttype] ADD  DEFAULT ((0)) FOR [frstlcost01]
GO
ALTER TABLE [dbo].[stcosttype] ADD  DEFAULT ((0)) FOR [pufrstlcost]
GO
ALTER TABLE [dbo].[stcosttype] ADD  DEFAULT ('') FOR [brlastissue]
GO
ALTER TABLE [dbo].[stcrtpuinv] ADD  CONSTRAINT [DF_stcrtpuinv_rplct_post]  DEFAULT ((0)) FOR [rplct_post]
GO
ALTER TABLE [dbo].[stcrtpuinv] ADD  DEFAULT ('') FOR [slcode]
GO
ALTER TABLE [dbo].[stdtl] ADD  CONSTRAINT [DF_stdtl_lprice]  DEFAULT ((0)) FOR [lprice]
GO
ALTER TABLE [dbo].[stdtl] ADD  CONSTRAINT [DF_stdtl_fcost]  DEFAULT ((0)) FOR [fcost]
GO
ALTER TABLE [dbo].[stdtl] ADD  CONSTRAINT [DF_stdtl_discpc]  DEFAULT ((0)) FOR [discpc]
GO
ALTER TABLE [dbo].[stdtl] ADD  CONSTRAINT [DF_stdtl_folio]  DEFAULT ((0)) FOR [folio]
GO
ALTER TABLE [dbo].[stdtl] ADD  CONSTRAINT [DF_stdtl_rplct_post]  DEFAULT ((0)) FOR [rplct_post]
GO
ALTER TABLE [dbo].[stdtl] ADD  DEFAULT ((0)) FOR [q_frt]
GO
ALTER TABLE [dbo].[sthdr] ADD  CONSTRAINT [DF_sthdr_entries]  DEFAULT ((0)) FOR [entries]
GO
ALTER TABLE [dbo].[sthdr] ADD  DEFAULT ((0)) FOR [repost]
GO
ALTER TABLE [dbo].[sthdr] ADD  DEFAULT ((0)) FOR [items_rcvd]
GO
ALTER TABLE [dbo].[sthdr] ADD  DEFAULT ((0)) FOR [trx_printed]
GO
ALTER TABLE [dbo].[sthdr] ADD  DEFAULT ('') FOR [pricetp]
GO
ALTER TABLE [dbo].[sthdr] ADD  DEFAULT ((0)) FOR [Damaged]
GO
ALTER TABLE [dbo].[stitembc] ADD  CONSTRAINT [DF_stitembc_pkqty]  DEFAULT ((1)) FOR [pkqty]
GO
ALTER TABLE [dbo].[stitembc] ADD  CONSTRAINT [DF_stitembc_weight]  DEFAULT ((0)) FOR [weight]
GO
ALTER TABLE [dbo].[stitembc] ADD  CONSTRAINT [DF_stitembc_pkorder]  DEFAULT ((0)) FOR [pkorder]
GO
ALTER TABLE [dbo].[stitems] ADD  CONSTRAINT [DF_stitems_vprice]  DEFAULT ((0)) FOR [vprice]
GO
ALTER TABLE [dbo].[stitems] ADD  CONSTRAINT [DF_stitems_fix_barcode]  DEFAULT ((1)) FOR [fix_barcode]
GO
ALTER TABLE [dbo].[stitems] ADD  DEFAULT ('') FOR [taxtype]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ((0)) FOR [ord_qty]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ('') FOR [mnimumdt]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ((0)) FOR [cust_pctg]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ((0)) FOR [is_double_width]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ((0)) FOR [is_price_per_length]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ((0)) FOR [is_accessory_stk_item]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ((0)) FOR [dsc_amt1]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ((0)) FOR [dsc_amt2]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ((0)) FOR [dsc_amt3]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ('') FOR [usrid]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ('') FOR [usrid_lstchg]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ('') FOR [exemption_reason_code]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ((0)) FOR [onlinesales]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ((0)) FOR [extra_tax_p]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ('') FOR [startdate]
GO
ALTER TABLE [dbo].[stitmphoto] ADD  DEFAULT ('') FOR [enddate]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_openlcost]  DEFAULT ((0)) FOR [openlcost]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_lcost]  DEFAULT ((0)) FOR [lcost]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_fprice1]  DEFAULT ((0)) FOR [fprice1]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_maxdisc1]  DEFAULT ((0)) FOR [maxdisc1]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_fprice2]  DEFAULT ((0)) FOR [fprice2]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_maxdisc2]  DEFAULT ((0)) FOR [maxdisc2]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_lprice3]  DEFAULT ((0)) FOR [lprice3]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_fprice3]  DEFAULT ((0)) FOR [fprice3]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_maxdisc3]  DEFAULT ((0)) FOR [maxdisc3]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_openfcost]  DEFAULT ((0)) FOR [openfcost]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_fcost]  DEFAULT ((0)) FOR [fcost]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_minstk]  DEFAULT ((0)) FOR [minstk]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_maxstk]  DEFAULT ((0)) FOR [maxstk]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_orderlevel]  DEFAULT ((0)) FOR [orderlevel]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_leadday]  DEFAULT ((0)) FOR [leadday]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_pkqty1]  DEFAULT ((0)) FOR [pkqty1]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_pkqty2]  DEFAULT ((0)) FOR [pkqty2]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_pkqty3]  DEFAULT ((0)) FOR [pkqty3]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_mnmprice]  DEFAULT ((0)) FOR [mnmprice]
GO
ALTER TABLE [dbo].[stunits] ADD  CONSTRAINT [DF_stunits_invqty]  DEFAULT ((0)) FOR [invqty]
GO
ALTER TABLE [dbo].[stwhous] ADD  DEFAULT ((0)) FOR [no_autosales]
GO
ALTER TABLE [dbo].[stwhous] ADD  DEFAULT ((0)) FOR [suspended]
GO
ALTER TABLE [dbo].[stwhous] ADD  DEFAULT ('A00001') FOR [binsrlno]
GO
ALTER TABLE [dbo].[stwhous] ADD  DEFAULT ((0)) FOR [xfrfm_mustbinnno]
GO
ALTER TABLE [dbo].[stwhous] ADD  DEFAULT ((0)) FOR [xfrto_mustbinnno]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_cu_opnbal]  DEFAULT ((0)) FOR [cu_opnbal]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_cu_curbal]  DEFAULT ((0)) FOR [cu_curbal]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_cf_opnfcy]  DEFAULT ((0)) FOR [cf_opnfcy]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_cf_curfcy]  DEFAULT ((0)) FOR [cf_curfcy]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_cu_lcaloc]  DEFAULT ((0)) FOR [cu_lcaloc]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF_supplier_cu_fcaloc]  DEFAULT ((0)) FOR [cu_fcaloc]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF__supplier__whno__4D9F7493]  DEFAULT ('') FOR [whno]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF__supplier__vndr_t__4E9398CC]  DEFAULT ('') FOR [vndr_taxcode]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF__supplier__taxFre__4F87BD05]  DEFAULT ((0)) FOR [taxFree]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF__supplier__cu_kin__507BE13E]  DEFAULT ('') FOR [cu_kind]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF__supplier__PriceI__526429B0]  DEFAULT ((0)) FOR [PriceIncludeVat]
GO
ALTER TABLE [dbo].[supplier] ADD  CONSTRAINT [DF__supplier__cu_typ__53584DE9]  DEFAULT ('') FOR [cu_type]
GO
ALTER TABLE [dbo].[sysgp] ADD  DEFAULT ('') FOR [ussctnalw]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_suspend]  DEFAULT ((0)) FOR [suspend]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_posuser]  DEFAULT ((0)) FOR [posuser]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_hide_jv]  DEFAULT ((0)) FOR [ushide_jv]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_uschdlcshinv]  DEFAULT ((0)) FOR [uschdlcshinv]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_uschdlcshrcv]  DEFAULT ((0)) FOR [uschdlcshrcv]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_uschdlchqrcv]  DEFAULT ((0)) FOR [uschdlchqrcv]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_us_no_profit]  DEFAULT ((0)) FOR [usshowprofit]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_goblwmnmp]  DEFAULT ((0)) FOR [goblwmnmp]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_mobileuser]  DEFAULT ((0)) FOR [mobileuser]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_confirmPurchase]  DEFAULT ((0)) FOR [confirmPurchase]
GO
ALTER TABLE [dbo].[sysuse] ADD  CONSTRAINT [DF_sysuse_noovrdrft]  DEFAULT ((0)) FOR [noovrdrft]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [onlyactrmt]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [confirmbr]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [confirmtrnsfr]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [nopriceblwcost]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [mgmtcnfrm]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ('') FOR [mobilNo]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [OTP]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ('') FOR [web_rights]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [NorgstrNoSl]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ('') FOR [ussctnalw]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [Noslsblwcst]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [AlwChangeVAT]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ('') FOR [emp_code]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [blkassmbld]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ('') FOR [usfpimage2]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [max_inv_printed]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [max_fsh_printed]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [usissrqst]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [usstiss]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [usstrcv]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((1)) FOR [e_invrdy]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [smartsearch]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [applymnmallprices]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((1)) FOR [smartsrch_itemBaltype]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [puinv_cost_notalwd]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [mnmppalw]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [nopostslinv]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [nopostpuinv]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [nopoststtrx]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [nochgmaxlmt]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [no_item_duplicate]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [no_item_srch_in_puinv]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [alwslfrmslnobal]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [nochngpromo]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [dsplyothersQH]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [hideqhinfo]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [alwchg_slrtn_price]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [noadd_crdt_clnt]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [archv_upload]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [archv_download]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [archv_open]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [archv_delete]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [alw2usewtsapp]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [alw2chgwtsmbl]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [smrtsrch4cmbkey]
GO
ALTER TABLE [dbo].[sysuse] ADD  DEFAULT ((0)) FOR [use_dashboard]
GO
ALTER TABLE [dbo].[ttkfile] ADD  DEFAULT ((0)) FOR [nobin]
GO
ALTER TABLE [dbo].[ttkhdr] ADD  DEFAULT ((0)) FOR [ttkmanual]
GO
ALTER TABLE [dbo].[apdtl]  WITH NOCHECK ADD  CONSTRAINT [FK_apdtl_aphdr1] FOREIGN KEY([dt_company], [dt_type], [dt_ref])
REFERENCES [dbo].[aphdr] ([hd_company], [hd_type], [hd_ref])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[apdtl] CHECK CONSTRAINT [FK_apdtl_aphdr1]
GO
ALTER TABLE [dbo].[ardtl]  WITH CHECK ADD  CONSTRAINT [FK_ardtl_arhdr1] FOREIGN KEY([dt_company], [dt_type], [dt_ref])
REFERENCES [dbo].[arhdr] ([hd_company], [hd_type], [hd_ref])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ardtl] CHECK CONSTRAINT [FK_ardtl_arhdr1]
GO
ALTER TABLE [dbo].[gljrcost]  WITH CHECK ADD  CONSTRAINT [FK_gljrcost_gljrdtl] FOREIGN KEY([company], [jdtype], [jdref], [jdfolno])
REFERENCES [dbo].[gljrdtl] ([jdcomp], [jdtype], [jdref], [jdfolno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[gljrcost] CHECK CONSTRAINT [FK_gljrcost_gljrdtl]
GO
ALTER TABLE [dbo].[gljrdtl]  WITH NOCHECK ADD  CONSTRAINT [FK_gljrdtl_gljrhdr] FOREIGN KEY([jdcomp], [jdtype], [jdref])
REFERENCES [dbo].[gljrhdr] ([jhcomp], [jhtype], [jhref])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[gljrdtl] CHECK CONSTRAINT [FK_gljrdtl_gljrhdr]
GO
ALTER TABLE [dbo].[jccstord_dtl]  WITH CHECK ADD  CONSTRAINT [FK_jccstord_dtl_jccstord_hdr] FOREIGN KEY([company], [refno])
REFERENCES [dbo].[jccstord_hdr] ([company], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[jccstord_dtl] CHECK CONSTRAINT [FK_jccstord_dtl_jccstord_hdr]
GO
ALTER TABLE [dbo].[jcstitems]  WITH CHECK ADD  CONSTRAINT [FK_jcstitems_stunits] FOREIGN KEY([cmbkey])
REFERENCES [dbo].[stunits] ([cmbkey])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[jcstitems] CHECK CONSTRAINT [FK_jcstitems_stunits]
GO
ALTER TABLE [dbo].[ord_dtl]  WITH CHECK ADD  CONSTRAINT [FK_ord_dtl_ord_hdr] FOREIGN KEY([company], [refno])
REFERENCES [dbo].[ord_hdr] ([company], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ord_dtl] CHECK CONSTRAINT [FK_ord_dtl_ord_hdr]
GO
ALTER TABLE [dbo].[pudtl]  WITH CHECK ADD  CONSTRAINT [FK_pudtl_puhdr] FOREIGN KEY([company], [invtype], [refno])
REFERENCES [dbo].[puhdr] ([company], [invtype], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[pudtl] CHECK CONSTRAINT [FK_pudtl_puhdr]
GO
ALTER TABLE [dbo].[sales_dd]  WITH CHECK ADD  CONSTRAINT [FK_sales_dd_sales_dh] FOREIGN KEY([company], [invtype], [refno])
REFERENCES [dbo].[sales_dh] ([company], [invtype], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sales_dd] CHECK CONSTRAINT [FK_sales_dd_sales_dh]
GO
ALTER TABLE [dbo].[sales_dt]  WITH CHECK ADD  CONSTRAINT [FK_sales_dt_sales_hd] FOREIGN KEY([company], [invtype], [refno])
REFERENCES [dbo].[sales_hd] ([company], [invtype], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sales_dt] CHECK CONSTRAINT [FK_sales_dt_sales_hd]
GO
ALTER TABLE [dbo].[sales_gd]  WITH CHECK ADD  CONSTRAINT [FK_sales_gd_sales_gh] FOREIGN KEY([company], [refno])
REFERENCES [dbo].[sales_gh] ([company], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sales_gd] CHECK CONSTRAINT [FK_sales_gd_sales_gh]
GO
ALTER TABLE [dbo].[sales_od]  WITH CHECK ADD  CONSTRAINT [FK_sales_od_sales_oh] FOREIGN KEY([company], [refno])
REFERENCES [dbo].[sales_oh] ([company], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sales_od] CHECK CONSTRAINT [FK_sales_od_sales_oh]
GO
ALTER TABLE [dbo].[sales_qd]  WITH CHECK ADD  CONSTRAINT [FK_Sales_qd_Sales_qh] FOREIGN KEY([company], [refno])
REFERENCES [dbo].[sales_qh] ([company], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sales_qd] CHECK CONSTRAINT [FK_Sales_qd_Sales_qh]
GO
ALTER TABLE [dbo].[sdaad_dt]  WITH NOCHECK ADD  CONSTRAINT [FK_sdaad_dt_sdaad_hd] FOREIGN KEY([company], [sdtype], [refno])
REFERENCES [dbo].[sdaad_hd] ([company], [sdtype], [refno])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[sdaad_dt] CHECK CONSTRAINT [FK_sdaad_dt_sdaad_hd]
GO
ALTER TABLE [dbo].[sddtl]  WITH NOCHECK ADD  CONSTRAINT [FK_sddtl_sdhdr] FOREIGN KEY([dt_company], [dt_type], [dt_ref])
REFERENCES [dbo].[sdhdr] ([hd_company], [hd_type], [hd_ref])
ON DELETE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[sddtl] CHECK CONSTRAINT [FK_sddtl_sdhdr]
GO
ALTER TABLE [dbo].[slfcypay]  WITH CHECK ADD  CONSTRAINT [FK_slfcypay_sales_hd] FOREIGN KEY([company], [invtype], [refno])
REFERENCES [dbo].[sales_hd] ([company], [invtype], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[slfcypay] CHECK CONSTRAINT [FK_slfcypay_sales_hd]
GO
ALTER TABLE [dbo].[st_slsord_dtl]  WITH CHECK ADD  CONSTRAINT [FK_st_slsord_dtl_sales_oh] FOREIGN KEY([branch], [refno])
REFERENCES [dbo].[sales_oh] ([company], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[st_slsord_dtl] CHECK CONSTRAINT [FK_st_slsord_dtl_sales_oh]
GO
ALTER TABLE [dbo].[stasmbld]  WITH CHECK ADD  CONSTRAINT [FK_stasmbld_stunits] FOREIGN KEY([itemno], [unicode])
REFERENCES [dbo].[stunits] ([itemno], [unicode])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[stasmbld] CHECK CONSTRAINT [FK_stasmbld_stunits]
GO
ALTER TABLE [dbo].[stbins]  WITH CHECK ADD  CONSTRAINT [FK_stbins_stunits] FOREIGN KEY([itemno], [unicode])
REFERENCES [dbo].[stunits] ([itemno], [unicode])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[stbins] CHECK CONSTRAINT [FK_stbins_stunits]
GO
ALTER TABLE [dbo].[stbrprice]  WITH CHECK ADD  CONSTRAINT [FK_stbrprice_stunits] FOREIGN KEY([itemno], [unicode])
REFERENCES [dbo].[stunits] ([itemno], [unicode])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[stbrprice] CHECK CONSTRAINT [FK_stbrprice_stunits]
GO
ALTER TABLE [dbo].[stcommission]  WITH CHECK ADD  CONSTRAINT [FK_stcommission_stunits] FOREIGN KEY([itemno], [unicode])
REFERENCES [dbo].[stunits] ([itemno], [unicode])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[stcommission] CHECK CONSTRAINT [FK_stcommission_stunits]
GO
ALTER TABLE [dbo].[stdtl]  WITH CHECK ADD  CONSTRAINT [FK_stdtl_sthdr] FOREIGN KEY([branch], [trtype], [refno])
REFERENCES [dbo].[sthdr] ([branch], [trtype], [refno])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[stdtl] CHECK CONSTRAINT [FK_stdtl_sthdr]
GO
ALTER TABLE [dbo].[stitembc]  WITH CHECK ADD  CONSTRAINT [FK_stitembc_stunits] FOREIGN KEY([itemno], [unicode])
REFERENCES [dbo].[stunits] ([itemno], [unicode])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[stitembc] CHECK CONSTRAINT [FK_stitembc_stunits]
GO
ALTER TABLE [dbo].[stitembc_brprice]  WITH CHECK ADD  CONSTRAINT [FK_stitembc_brprice_stitembc] FOREIGN KEY([pbarcode])
REFERENCES [dbo].[stitembc] ([pbarcode])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[stitembc_brprice] CHECK CONSTRAINT [FK_stitembc_brprice_stitembc]
GO
ALTER TABLE [dbo].[stitempictures]  WITH CHECK ADD  CONSTRAINT [FK_stitempictures_stunits] FOREIGN KEY([cmbkey])
REFERENCES [dbo].[stunits] ([cmbkey])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[stitempictures] CHECK CONSTRAINT [FK_stitempictures_stunits]
GO
ALTER TABLE [dbo].[stitmphoto]  WITH CHECK ADD  CONSTRAINT [FK_stitmphoto_stunits] FOREIGN KEY([itemno], [unicode])
REFERENCES [dbo].[stunits] ([itemno], [unicode])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[stitmphoto] CHECK CONSTRAINT [FK_stitmphoto_stunits]
GO
ALTER TABLE [dbo].[supplier_ei]  WITH CHECK ADD  CONSTRAINT [FK_supplier_supplier_ei] FOREIGN KEY([cu_company], [cu_code], [cf_fcy])
REFERENCES [dbo].[supplier] ([cu_company], [cu_code], [cf_fcy])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[supplier_ei] CHECK CONSTRAINT [FK_supplier_supplier_ei]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This can be used for Rebate losses Account' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'apclass', @level2type=N'COLUMN',@level2name=N'cl_salser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1= as selected and must select at least one warehouse selected
 2=all branch warehouses ( must not select any ware house)
3=No warehouse 
4=' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'glcstctr', @level2type=N'COLUMN',@level2name=N'whtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'حساب تخفيضات' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'glsction', @level2type=N'COLUMN',@level2name=N'rebate_act'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'حساب خسائر التخفيضات' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'glsction', @level2type=N'COLUMN',@level2name=N'lossRebateAct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'fasoohat fees' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pudept', @level2type=N'COLUMN',@level2name=N'chk_serfre'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'transportation ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'pudept', @level2type=N'COLUMN',@level2name=N'chk_sertrn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Expense Distribution Method 1-Value 2-CBM 3- Weight 4-Percent' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'puhdr', @level2type=N'COLUMN',@level2name=N'edm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'this field is used to hold the value of offer_amt that comming from POS' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sales_dt', @level2type=N'COLUMN',@level2name=N'imfcval'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'388 = tax invoice 383=Debit Note  381= Credit Note' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sales_ei', @level2type=N'COLUMN',@level2name=N'InvoiceTypeCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'01 = tax invoice 02 simplified Tax Invoice' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sales_ei', @level2type=N'COLUMN',@level2name=N'tax_invoice_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'10 = Cash  30 = Credit   42 = Payment to bank account   48 = Bank Card 1= others' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sales_ei', @level2type=N'COLUMN',@level2name=N'PaymentType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'NNPNESB' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sales_ei', @level2type=N'COLUMN',@level2name=N'InvoiceTransactionCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0=invoice created by infosoft account  1= Invoice created by Infosrvr for cash sales  (invorrtrn=1)  2= Invoice created by Infosrvr for Sales Replacement (invorrtrn=2)  3= Invoice created by Infosrvr for Sales Replacement (invorrtrn=3)
 4= Invoice created by PDA device' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sales_hd', @level2type=N'COLUMN',@level2name=N'posinv'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0= do not notify 1=Notify by email   2= Notify by SMS  3=Notify at login time' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'salesmen', @level2type=N'COLUMN',@level2name=N'notify_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'this can be used for Rebate losses' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'slclass', @level2type=N'COLUMN',@level2name=N'srslcst'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = No commessiion ,  2= commession allowed without targat , 3= commessiion allowed with monthly targat  4= comm with annual  target' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'stcommission', @level2type=N'COLUMN',@level2name=N'commtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'dbcxxYyy= yy example dbc01y14  means this field must be=14' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'stcrtpuinv', @level2type=N'COLUMN',@level2name=N'dbxyr'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Purchase Invoice date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'stcrtpuinv', @level2type=N'COLUMN',@level2name=N'idate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'used for transaction between branch and can be used to slcenter of pu & sl ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sthdr', @level2type=N'COLUMN',@level2name=N'tobrno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'this used for assembled item but if the value is 9 this means its transfer trx from trx between branch system' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sthdr', @level2type=N'COLUMN',@level2name=N'asmtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Repost those transactions that were not entered in this local database' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sthdr', @level2type=N'COLUMN',@level2name=N'repost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'if true user can sale below minimum sales price of items' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysuse', @level2type=N'COLUMN',@level2name=N'goblwmnmp'
GO
