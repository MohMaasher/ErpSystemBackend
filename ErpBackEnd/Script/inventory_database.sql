USE [dbc01y30]
GO
/****** Object:  Table [dbo].[orpacking]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stbins]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stbranch]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stbrprice]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stclass]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stdtl]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[sthdr]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stitembc]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stitembc_brprice]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stitems]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stitmphoto]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stprice]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stunits]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[stwhous]    Script Date: 2025-11-15 12:10:41 PM ******/
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
/****** Object:  Table [dbo].[supplier]    Script Date: 2025-11-15 12:10:41 PM ******/
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
ALTER TABLE [dbo].[orpacking] ADD  DEFAULT ((0)) FOR [pkwhlsl]
GO
ALTER TABLE [dbo].[orpacking] ADD  DEFAULT ('') FOR [standard_unit_code]
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
ALTER TABLE [dbo].[stitmphoto]  WITH CHECK ADD  CONSTRAINT [FK_stitmphoto_stunits] FOREIGN KEY([itemno], [unicode])
REFERENCES [dbo].[stunits] ([itemno], [unicode])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[stitmphoto] CHECK CONSTRAINT [FK_stitmphoto_stunits]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'used for transaction between branch and can be used to slcenter of pu & sl ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sthdr', @level2type=N'COLUMN',@level2name=N'tobrno'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'this used for assembled item but if the value is 9 this means its transfer trx from trx between branch system' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sthdr', @level2type=N'COLUMN',@level2name=N'asmtype'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Repost those transactions that were not entered in this local database' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sthdr', @level2type=N'COLUMN',@level2name=N'repost'
GO