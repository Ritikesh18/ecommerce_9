-- Table: public.cart

-- DROP TABLE IF EXISTS public.cart;

CREATE TABLE IF NOT EXISTS public.cart
(
    user_id bigint NOT NULL,
    CONSTRAINT cart_pkey1 PRIMARY KEY (user_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.cart
    OWNER to postgres;
	
----------------------------------------------------

-- Table: public.discount

-- DROP TABLE IF EXISTS public.discount;

CREATE TABLE IF NOT EXISTS public.discount
(
    id character varying COLLATE pg_catalog."default" NOT NULL,
    status bigint,
    CONSTRAINT discount_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.discount
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.order_main

-- DROP TABLE IF EXISTS public.order_main;

CREATE TABLE IF NOT EXISTS public.order_main
(
    order_id bigint NOT NULL,
    buyer_address character varying(255) COLLATE pg_catalog."default",
    buyer_email character varying(255) COLLATE pg_catalog."default",
    buyer_name character varying(255) COLLATE pg_catalog."default",
    buyer_phone character varying(255) COLLATE pg_catalog."default",
    create_time timestamp without time zone,
    order_amount numeric(19,2) NOT NULL,
    order_status integer NOT NULL DEFAULT 0,
    update_time timestamp without time zone,
    CONSTRAINT order_main_pkey PRIMARY KEY (order_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.order_main
    OWNER to postgres;
	
------------------------------------------------------

-- Table: public.product_category

-- DROP TABLE IF EXISTS public.product_category;

CREATE TABLE IF NOT EXISTS public.product_category
(
    category_id integer NOT NULL,
    category_name character varying(255) COLLATE pg_catalog."default",
    category_type integer,
    create_time timestamp without time zone,
    update_time timestamp without time zone,
    CONSTRAINT product_category_pkey PRIMARY KEY (category_id),
    CONSTRAINT uk_6kq6iveuim6wd90cxo5bksumw UNIQUE (category_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_category
    OWNER to postgres;
	
--------------------------------------------------------

-- Table: public.product_in_order

-- DROP TABLE IF EXISTS public.product_in_order;

CREATE TABLE IF NOT EXISTS public.product_in_order
(
    id bigint NOT NULL,
    category_type integer NOT NULL,
    count integer,
    product_description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_id character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default",
    product_price numeric(19,2) NOT NULL,
    product_stock integer,
    cart_user_id bigint,
    order_id bigint,
    CONSTRAINT product_in_order_pkey PRIMARY KEY (id),
    CONSTRAINT fkt0sfj3ffasrift1c4lv3ra85e FOREIGN KEY (order_id)
        REFERENCES public.order_main (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT product_cart_fkey FOREIGN KEY (cart_user_id)
        REFERENCES public.cart (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_in_order_count_check CHECK (count >= 1),
    CONSTRAINT product_in_order_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_in_order
    OWNER to postgres;
	
------------------------------------------------------------

-- Table: public.product_info

-- DROP TABLE IF EXISTS public.product_info;

CREATE TABLE IF NOT EXISTS public.product_info
(
    product_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    category_type integer DEFAULT 0,
    create_time timestamp without time zone,
    product_description character varying(255) COLLATE pg_catalog."default",
    product_icon character varying(255) COLLATE pg_catalog."default",
    product_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
    product_price numeric(19,2) NOT NULL,
    product_status integer DEFAULT 0,
    product_stock integer NOT NULL,
    update_time timestamp without time zone,
    CONSTRAINT product_info_pkey PRIMARY KEY (product_id),
    CONSTRAINT product_info_product_stock_check CHECK (product_stock >= 0)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.product_info
    OWNER to postgres;
	
-----------------------------------------------------------------

-- Table: public.tokens

-- DROP TABLE IF EXISTS public.tokens;

CREATE TABLE IF NOT EXISTS public.tokens
(
    id integer NOT NULL DEFAULT nextval('tokens_id_seq'::regclass),
    created_date timestamp without time zone,
    token character varying(255) COLLATE pg_catalog."default",
    user_id bigint NOT NULL,
    CONSTRAINT tokens_pkey PRIMARY KEY (id),
    CONSTRAINT fk2dylsfo39lgjyqml2tbe0b0ss FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tokens
    OWNER to postgres;
	
--------------------------------------------------------------------------

-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL,
    active boolean NOT NULL,
    address character varying(255) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    name character varying(255) COLLATE pg_catalog."default",
    password character varying(255) COLLATE pg_catalog."default",
    phone character varying(255) COLLATE pg_catalog."default",
    role character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uk_sx468g52bpetvlad2j9y0lptc UNIQUE (email)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to postgres;
	
---------------------------------------------------------------------------

-- Table: public.wishlist

-- DROP TABLE IF EXISTS public.wishlist;

CREATE TABLE IF NOT EXISTS public.wishlist
(
    id bigint NOT NULL,
    created_date timestamp without time zone,
    user_id bigint,
    product_id character varying COLLATE pg_catalog."default",
    CONSTRAINT wishlist_pkey PRIMARY KEY (id),
    CONSTRAINT product_wish_fkey FOREIGN KEY (product_id)
        REFERENCES public.product_info (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "user_wish_Fkey" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.wishlist
    OWNER to postgres;
	
---------------------------------------------------------------------------------------------------






--Product_Info


INSERT INTO "public"."product_category" VALUES (2147483641, 'Office Chairs', 0, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483642, 'Wall Sculptures', 1, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483643, 'Paintings', 2, '2022-06-23 23:03:26', '2022-06-23 23:03:26');
INSERT INTO "public"."product_category" VALUES (2147483644, 'Artificial Flora', 3, '2022-06-23 23:03:26', '2022-06-23 23:03:26');


--Product


INSERT INTO "public"."product_info" VALUES ('IF001', 0, '2022-08-17 22:02:30', 'Ine Mid Back Ergonomic Chair In Black Colour', 'https://ii1.pepperfry.com/media/catalog/product/i/n/800x880/ine-mid-back-ergonomic-chair-in-black-colour-by-valuewud-ine-mid-back-ergonomic-chair-in-black-colou-ydq0mb.jpg', 'Erognomic Chair', 50.00, 0, 22, '2022-08-21 22:03:26');
INSERT INTO "public"."product_info" VALUES ('IF002', 0, '2022-08-18 22:02:30', 'Monster Ultimate (T) Gaming Chair in Black & Grey Colour', 'https://ii1.pepperfry.com/media/catalog/product/b/e/494x544/beast-gaming-chair-in-black---grey-colour-by-green-soul-beast-gaming-chair-in-black---grey-colour-by-dbzyio.jpg', 'Ultimate Gaming Chair', 65.00, 0, 60, '2022-08-21 21:03:26');
INSERT INTO "public"."product_info" VALUES ('IF003', 0, '2022-08-16 22:02:30', 'Gold Gaming Chair With Footrest In Grey & Black Colour', 'https://ii1.pepperfry.com/media/catalog/product/m/o/494x544/monster-ultimate--t--gaming-chair-in-black---red-colour-by-green-soul-monster-ultimate--t--gaming-ch-mugd9c.jpg', 'Pro Gaming Chair', 45.00, 0, 40, '2022-08-20 22:03:26');
INSERT INTO "public"."product_info" VALUES ('IF004', 0, '2022-08-21 22:02:30', 'Beast Chair In Black Colour', 'https://ii2.pepperfry.com/media/catalog/product/a/l/494x544/altro-gaming-chair-in-black---red-colour-by-bantia-furniture-altro-gaming-chair-in-black---red-colou-zw5ons.jpg', 'Champion Chair', 50.00, 0, 22, '2022-08-21 10:03:26');
INSERT INTO "public"."product_info" VALUES ('IF005', 0, '2022-08-21 22:02:30', 'Devil (T) Gaming Chair in Black & Grey Colour', 'https://ii1.pepperfry.com/media/catalog/product/r/a/494x544/racing-ergonomic-chair-in-red---black-colour-by-bantia-furniture-racing-ergonomic-chair-in-red---bla-ym0maw.jpg', 'Noob Gaming Chair', 65.00, 0, 60, '2022-08-21 20:03:26');
INSERT INTO "public"."product_info" VALUES ('IF006', 0, '2022-08-21 22:02:30', 'Diamond Black Colour', 'https://ii3.pepperfry.com/media/catalog/product/r/a/494x544/racing-ergonomic-chair-in-grey---black-colour-by-bantia-furniture-racing-ergonomic-chair-in-grey---b-ctsqyw.jpg', 'Pushpa Chair', 45.00, 0, 40, '2022-08-20 12:03:26');






INSERT INTO "public"."product_info" VALUES ('WS001', 1, '2022-08-18 22:02:25', 'Handmade Hand-Painted and Beautifull Wall Hanging', 'https://ii2.pepperfry.com/media/catalog/product/m/u/494x544/multicolour-mdf-printed-colorful-abstract-clouds-multi-frame-painting-by-999store-multicolour-mdf-pr-6yknfb.jpg', 'Canvas Yellow & Black Abstract Set Of 3 Framed Art Print', 53.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS002', 1, '2022-08-18 22:02:25', 'Pink and Attractive Color Wall Arts for Home', 'https://ii3.pepperfry.com/media/catalog/product/n/a/494x544/nature-theme-canvas-art-print-painting-set-of-2-by-art-street-nature-theme-canvas-art-print-painting-x2rd5x.jpg', 'Pink 3D Embossed Floral Original Hand Painting On Canvas', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS003', 1, '2022-08-18 22:02:25', 'Green Leaf Wall Hanging Painting for lobby and drawing room', 'https://ii3.pepperfry.com/media/catalog/product/b/l/494x544/blue-color-abstract-theme-framed-canvas-art-print-painting-set-of-2-by-art-street-blue-color-abstrac-zbkmdn.jpg', 'Blue Color Abstract Theme Framed Canvas Art Print Painting Set Of 2', 45.00, 0, 50, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS004', 1, '2022-08-18 22:02:25', 'Beautifull Wall Hanging', 'https://ii3.pepperfry.com/media/catalog/product/a/b/494x544/abstract-multicolour-synthetic-wall-painting-by-random-abstract-multicolour-synthetic-wall-painting--nl8l4b.jpg', 'Lord Budha Framed Art Print', 53.00, 0, 22, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS005', 1, '2022-08-18 22:02:25', 'Attractive Color Wall Arts for Home', 'https://ii2.pepperfry.com/media/catalog/product/m/u/494x544/multicolour-wood-beautifully-printed-buddha-wall-art-painting-by-story-home-multicolour-wood-beautif-be6nln.jpg', '40X30 Inches Framed Canvas Painting ', 85.00, 0, 10, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('WS006', 1, '2022-08-18 22:02:25', 'Hanging Painting for Motivating yourself', 'https://ii2.pepperfry.com/media/catalog/product/a/b/494x544/abstract-multicolour-synthetic-wall-painting-by-random-abstract-multicolour-synthetic-wall-painting--nysl3x.jpg', 'Art Print Painting Set Of 2', 45.00, 0, 50, '2022-06-23 23:03:26');



INSERT INTO "public"."product_info" VALUES ('PA001', 2, '2022-08-18 23:03:26', 'Polished Fine art small with Led Light', 'https://ii2.pepperfry.com/media/catalog/product/v/o/494x544/votive-shape-planter--set-of-3-by-the-craze-by-amaya-decors-votive-shape-planter--set-of-3-by-the-cr-7iepze.jpg', 'Votive Shape Planter, Set Of 3', 73.00, 0, 45, '2022-08-20 22:02:25');
INSERT INTO "public"."product_info" VALUES ('PA002', 2, '2022-08-18 23:03:26', 'Beautifull attractive set of pots', 'https://ii2.pepperfry.com/media/catalog/product/h/a/494x544/halianthus-floral-pottery-ceramic-table-vase-by-folkstorys-halianthus-floral-pottery-ceramic-table-v-h6bif4.jpg', 'Beautifull set of Pots', 57.00, 0, 53, '2022-08-20 22:02:25');
INSERT INTO "public"."product_info" VALUES ('PA003', 2, '2022-08-18 23:03:26', 'Musician Rajasthani culture ', 'https://ii1.pepperfry.com/media/catalog/product/m/u/494x544/musician--set-of-2--iron-human-figurine-by-craft-tree-musician--set-of-2--iron-human-figurine-by-cra-f8xwwm.jpg', 'Musician (Set of 2) Iron Human Figurine', 95.00, 0, 70, '2022-08-20 22:02:24');
INSERT INTO "public"."product_info" VALUES ('PA004', 2, '2022-08-18 23:03:26', 'Fine Art Home Decor Metal Art & Craft Bird Ring Small with Led Light', 'https://m.media-amazon.com/images/I/81+mbR9nw-L._SX679_.jpg', 'Home Decor Metal Art ', 73.00, 0, 45, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA005', 2, '2022-08-18 23:03:26', 'World Decor Led Couple Peacock Birds Metal Wall Art - Big, Multicolour', 'https://m.media-amazon.com/images/I/61LsEgD7uTL._SX679_.jpg', 'Led Couple Peacock Birds', 57.00, 0, 53, '2022-06-23 23:03:26');
INSERT INTO "public"."product_info" VALUES ('PA006', 2, '2022-08-18 23:03:26', 'Fine Art Home Decor Metal & MDF Art & Craft Bike Panel', 'https://m.media-amazon.com/images/I/81wdvBLTBkL._SX679_.jpg', 'Home Decor Metal & MDF Art ', 95.00, 0, 70, '2022-06-23 23:03:26');





INSERT INTO "public"."product_info" VALUES ('AF001', 3, '2022-08-22 23:03:26', 'Arrangement Indoor Plant-orchid bouquet', 'https://ii1.pepperfry.com/media/catalog/product/p/i/494x544/pink-polyester-artificial-rose-flower--set-of-12-without-pot-by-tied-ribbons-pink-polyester-artifici-smk9c8.jpg', 'Purple Polyester Artificial Tulip Flower Bunch', 90.00, 0, 39, '2022-08-20 22:02:26');
INSERT INTO "public"."product_info" VALUES ('AF002', 3, '2022-08-22 23:03:26', 'Cherry Orchid Flower Bunch', 'https://ii2.pepperfry.com/media/catalog/product/y/e/494x544/yellow-polyester-artificial-tulip-flower--set-of-5-without-pot-by-tied-ribbons-yellow-polyester-arti-cburza.jpg', 'Pink Synthetic Artificial Carnation Stem, Set Of 15', 76.00, 0, 75, '2022-08-20 22:02:26');
INSERT INTO "public"."product_info" VALUES ('AF003', 3, '2022-08-22 23:03:26', 'Wall Home Door Decoration Theme', 'https://ii2.pepperfry.com/media/catalog/product/l/i/494x544/light-pink-fabric-artificial-exquisite-lily-flower-by-pollination-light-pink-fabric-artificial-exqui-dqzxd7.jpg', 'White Polyester Artificial Calla Lily Flower, Set Of 10 Without Pot', 82.00, 0, 20, '2022-08-20 22:02:26');
INSERT INTO "public"."product_info" VALUES ('AF004', 3, '2022-08-22 23:03:26', 'unique flower- Fresh Flowers Bouquet Arrangement Indoor Plant-orchid bouquet', 'https://images-eu.ssl-images-amazon.com/images/I/51pGF656WoL._SX300_SY300_QL70_FMwebp_.jpg', 'Fresh Flowers Bouquet  ', 90.00, 0, 39, '2022-08-20 22:08:26');
INSERT INTO "public"."product_info" VALUES ('AF005', 3, '2022-08-22 23:03:26', 'Blooming Floret Artificial Cherry Orchid Flower Bunch', 'https://m.media-amazon.com/images/I/81MCELCKR4L._SY879_.jpg', 'Artificial Cherry Orchid Flower', 76.00, 0, 75, '2022-08-20 23:03:26');
INSERT INTO "public"."product_info" VALUES ('AF006', 3, '2022-08-22 23:03:26', 'Diwali Wedding Party Garden Craft Wall Home Door Decoration Theme', 'https://m.media-amazon.com/images/I/715VQFzLwRL._SX679_.jpg', 'Artificial Marigold Flower ', 82.00, 0, 20, '2022-08-20 23:03:26');



--Users

INSERT INTO "public"."users" VALUES (2147483645, true, 'Plot 2, Shivaji Nagar, Benagluru', 'admin@eshop.com', 'Admin', '$2a$10$LiBwO43TpKU0sZgCxNkWJueq2lqxoUBsX2Wclzk8JQ3Ejb9MWu2Xy', '1234567890', 'ROLE_MANAGER');

CREATE SEQUENCE IF NOT EXISTS public.hibernate_sequence
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

ALTER SEQUENCE public.hibernate_sequence
    OWNER TO postgres;