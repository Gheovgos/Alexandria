PGDMP     :                    {           bibliografia    15.1    15.1 3    >           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            @           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            A           1262    16825    bibliografia    DATABASE        CREATE DATABASE bibliografia WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';
    DROP DATABASE bibliografia;
                postgres    false            U           1247    17120 	   tipo_enum    TYPE     x   CREATE TYPE public.tipo_enum AS ENUM (
    'Conferenza',
    'Libro',
    'Rivista',
    'Fascicolo',
    'Articolo'
);
    DROP TYPE public.tipo_enum;
       public          postgres    false            �            1255    17229    articolo_check()    FUNCTION     E  CREATE FUNCTION public.articolo_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Articolo' AND (NEW.ISBN IS NOT NULL OR NEW.Luogo IS NOT NULL OR NEW.Editore IS NOT NULL OR NEW.Edizione IS NOT NULL OR NEW.DOI IS NOT NULL) THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 '   DROP FUNCTION public.articolo_check();
       public          postgres    false            �            1255    17227    conferenza_check()    FUNCTION     �  CREATE FUNCTION public.conferenza_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Conferenza' AND (NEW.ISNN IS NOT NULL OR NEW.ISBN IS NOT NULL OR NEW.Pag_Inizio IS NOT NULL OR NEW.Pag_Fine IS NOT NULL OR NEW.DOI IS NOT NULL
OR NEW.Edizione IS NOT NULL OR NEW.Editore IS NOT NULL) THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 )   DROP FUNCTION public.conferenza_check();
       public          postgres    false            �            1255    17233    fascicolo_check()    FUNCTION     �  CREATE FUNCTION public.fascicolo_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Fascicolo' AND (NEW.ISBN IS NOT NULL OR NEW.Luogo IS NOT NULL OR NEW.Editore IS NOT NULL OR NEW.Edizione IS NOT NULL OR NEW.ISNN IS NOT NULL
	OR NEW.Pag_Fine IS NOT NULL OR NEW.Pag_Inizio IS NOT NULL) THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 (   DROP FUNCTION public.fascicolo_check();
       public          postgres    false            �            1255    17225    libro_check()    FUNCTION     B  CREATE FUNCTION public.libro_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Libro' AND (NEW.ISNN IS NOT NULL OR NEW.Luogo IS NOT NULL OR NEW.Pag_Inizio IS NOT NULL OR NEW.Pag_Fine IS NOT NULL OR NEW.DOI IS NOT NULL) THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 $   DROP FUNCTION public.libro_check();
       public          postgres    false            �            1255    17223    online_check()    FUNCTION     �   CREATE FUNCTION public.online_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.On_line = false AND NEW.URL IS NOT NULL THEN
	RAISE EXCEPTION 'Non puoi inserire un URL se il riferimento è offline';
END IF;
RETURN NEW;
END;
$$;
 %   DROP FUNCTION public.online_check();
       public          postgres    false            �            1255    17231    rivista_check()    FUNCTION     ~  CREATE FUNCTION public.rivista_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Rivista' AND (NEW.ISBN IS NOT NULL OR NEW.Luogo IS NOT NULL OR NEW.Editore IS NOT NULL OR NEW.Edizione IS NOT NULL OR NEW.DOI IS NOT NULL
	OR NEW.Pag_Fine IS NOT NULL OR NEW.Pag_Inizio IS NOT NULL) THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 &   DROP FUNCTION public.rivista_check();
       public          postgres    false            �            1255    17236    sub_cat(integer)    FUNCTION     �  CREATE FUNCTION public.sub_cat(catin integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
codiciString VARCHAR(100) := '';
catTmp integer := catIn;
i record;
BEGIN
FOR i IN (SELECT ID_Categoria FROM Categoria WHERE ID_Super_Categoria = catTmp)
LOOP
	codiciString := codiciString||i.ID_Categoria||',';
	codiciString := codiciString||sub_cat(i.ID_Categoria);
END LOOP;
codiciString := RTRIM(codiciString,',');
RETURN codiciString;
END;
$$;
 -   DROP FUNCTION public.sub_cat(catin integer);
       public          postgres    false            �            1255    17235    super_cat(integer)    FUNCTION     +  CREATE FUNCTION public.super_cat(catin integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $$
DECLARE
codiciString VARCHAR(100) := '';
catTmp integer := catIn;
supercatTmp integer := (SELECT ID_Super_Categoria FROM Categoria WHERE ID_Categoria = catTmp);
BEGIN
WHILE supercatTmp IS NOT NULL
BEGIN LOOP
	codiciString := codiciString||supercatTmp||',';
	catTmp := supercatTmp;
	supercatTmp := (SELECT ID_Super_Categoria FROM Categoria WHERE ID_Categoria = catTmp);
END LOOP;
codiciString := RTRIM(codiciString,',');
RETURN codiciString;
END;
$$;
 /   DROP FUNCTION public.super_cat(catin integer);
       public          postgres    false            �            1259    17131 !   associativa_riferimenti_categoria    TABLE     �   CREATE TABLE public.associativa_riferimenti_categoria (
    id_riferimento integer NOT NULL,
    id_categoria integer NOT NULL
);
 5   DROP TABLE public.associativa_riferimenti_categoria;
       public         heap    postgres    false            �            1259    17134    associazione_riferimenti    TABLE     �   CREATE TABLE public.associazione_riferimenti (
    id_riferimento integer NOT NULL,
    id_riferimento_associato integer NOT NULL
);
 ,   DROP TABLE public.associazione_riferimenti;
       public         heap    postgres    false            �            1259    17137    autore_riferimento    TABLE     �   CREATE TABLE public.autore_riferimento (
    id_utente integer NOT NULL,
    descr_utente character varying(500),
    id_riferimento integer NOT NULL,
    ordine integer NOT NULL
);
 &   DROP TABLE public.autore_riferimento;
       public         heap    postgres    false            �            1259    17143 	   categoria    TABLE     �   CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    descr_categoria character varying(500) NOT NULL,
    id_super_categoria integer,
    id_utente integer
);
    DROP TABLE public.categoria;
       public         heap    postgres    false            �            1259    17142    categoria_id_categoria_seq    SEQUENCE     �   ALTER TABLE public.categoria ALTER COLUMN id_categoria ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.categoria_id_categoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            �            1259    17151    riferimenti_biblio    TABLE       CREATE TABLE public.riferimenti_biblio (
    id_riferimento integer NOT NULL,
    titolo_riferimento character varying(200) NOT NULL,
    data_riferimento date,
    on_line boolean NOT NULL,
    tipo character varying(50) NOT NULL,
    url character varying(500),
    doi integer,
    descr_riferimento character varying(1000),
    editore character varying(1000),
    isbn character varying(20),
    isnn character varying(20),
    luogo character varying(100),
    pag_inizio integer,
    pag_fine integer,
    edizione integer
);
 &   DROP TABLE public.riferimenti_biblio;
       public         heap    postgres    false            �            1259    17150 %   riferimenti_biblio_id_riferimento_seq    SEQUENCE     �   ALTER TABLE public.riferimenti_biblio ALTER COLUMN id_riferimento ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.riferimenti_biblio_id_riferimento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            �            1259    17167    utente    TABLE       CREATE TABLE public.utente (
    user_id integer NOT NULL,
    username character varying(20) NOT NULL,
    nome character varying(200) NOT NULL,
    cognome character varying(200) NOT NULL,
    password_hashed character varying(500),
    salt character varying(500)
);
    DROP TABLE public.utente;
       public         heap    postgres    false            �            1259    17166    utente_id_utente_seq    SEQUENCE     �   ALTER TABLE public.utente ALTER COLUMN user_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.utente_id_utente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    222            3          0    17131 !   associativa_riferimenti_categoria 
   TABLE DATA           Y   COPY public.associativa_riferimenti_categoria (id_riferimento, id_categoria) FROM stdin;
    public          postgres    false    214   tN       4          0    17134    associazione_riferimenti 
   TABLE DATA           \   COPY public.associazione_riferimenti (id_riferimento, id_riferimento_associato) FROM stdin;
    public          postgres    false    215   �N       5          0    17137    autore_riferimento 
   TABLE DATA           ]   COPY public.autore_riferimento (id_utente, descr_utente, id_riferimento, ordine) FROM stdin;
    public          postgres    false    216   &O       7          0    17143 	   categoria 
   TABLE DATA           a   COPY public.categoria (id_categoria, descr_categoria, id_super_categoria, id_utente) FROM stdin;
    public          postgres    false    218   �O       9          0    17151    riferimenti_biblio 
   TABLE DATA           �   COPY public.riferimenti_biblio (id_riferimento, titolo_riferimento, data_riferimento, on_line, tipo, url, doi, descr_riferimento, editore, isbn, isnn, luogo, pag_inizio, pag_fine, edizione) FROM stdin;
    public          postgres    false    220   �Q       ;          0    17167    utente 
   TABLE DATA           Y   COPY public.utente (user_id, username, nome, cognome, password_hashed, salt) FROM stdin;
    public          postgres    false    222   �S       B           0    0    categoria_id_categoria_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 1, false);
          public          postgres    false    217            C           0    0 %   riferimenti_biblio_id_riferimento_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.riferimenti_biblio_id_riferimento_seq', 1, false);
          public          postgres    false    219            D           0    0    utente_id_utente_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.utente_id_utente_seq', 1, false);
          public          postgres    false    221            �           2606    17218 X   associazione_riferimenti associazione_riferimenti_id_riferimento_id_riferimento_asso_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.associazione_riferimenti
    ADD CONSTRAINT associazione_riferimenti_id_riferimento_id_riferimento_asso_key UNIQUE (id_riferimento, id_riferimento_associato);
 �   ALTER TABLE ONLY public.associazione_riferimenti DROP CONSTRAINT associazione_riferimenti_id_riferimento_id_riferimento_asso_key;
       public            postgres    false    215    215            �           2606    17222 I   autore_riferimento autore_riferimento_id_utente_id_riferimento_ordine_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.autore_riferimento
    ADD CONSTRAINT autore_riferimento_id_utente_id_riferimento_ordine_key UNIQUE (id_utente, id_riferimento, ordine);
 s   ALTER TABLE ONLY public.autore_riferimento DROP CONSTRAINT autore_riferimento_id_utente_id_riferimento_ordine_key;
       public            postgres    false    216    216    216            �           2606    17220 7   categoria categoria_id_categoria_id_super_categoria_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_id_categoria_id_super_categoria_key UNIQUE (id_categoria, id_super_categoria);
 a   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_id_categoria_id_super_categoria_key;
       public            postgres    false    218    218            �           2606    17149    categoria categoria_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);
 B   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_pkey;
       public            postgres    false    218            �           2606    17161 -   riferimenti_biblio riferimenti_biblio_doi_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_doi_key UNIQUE (doi);
 W   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_doi_key;
       public            postgres    false    220            �           2606    17163 .   riferimenti_biblio riferimenti_biblio_isbn_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_isbn_key UNIQUE (isbn);
 X   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_isbn_key;
       public            postgres    false    220            �           2606    17165 .   riferimenti_biblio riferimenti_biblio_isnn_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_isnn_key UNIQUE (isnn);
 X   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_isnn_key;
       public            postgres    false    220            �           2606    17157 *   riferimenti_biblio riferimenti_biblio_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_pkey PRIMARY KEY (id_riferimento);
 T   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_pkey;
       public            postgres    false    220            �           2606    17159 -   riferimenti_biblio riferimenti_biblio_url_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_url_key UNIQUE (url);
 W   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_url_key;
       public            postgres    false    220            �           2606    17174    utente utente_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (user_id);
 <   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_pkey;
       public            postgres    false    222            �           2606    17176    utente utente_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_username_key;
       public            postgres    false    222            �           2620    17224    riferimenti_biblio online_check    TRIGGER     �   CREATE TRIGGER online_check AFTER INSERT OR UPDATE OF on_line ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.online_check();
 8   DROP TRIGGER online_check ON public.riferimenti_biblio;
       public          postgres    false    220    223    220            �           2606    17182 1   associativa_riferimenti_categoria fk_id_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.associativa_riferimenti_categoria
    ADD CONSTRAINT fk_id_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.associativa_riferimenti_categoria DROP CONSTRAINT fk_id_categoria;
       public          postgres    false    218    3213    214            �           2606    17212     categoria fk_id_categoria_utente    FK CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_id_categoria_utente FOREIGN KEY (id_utente) REFERENCES public.utente(user_id) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.categoria DROP CONSTRAINT fk_id_categoria_utente;
       public          postgres    false    218    222    3225            �           2606    17177 3   associativa_riferimenti_categoria fk_id_riferimento    FK CONSTRAINT     �   ALTER TABLE ONLY public.associativa_riferimenti_categoria
    ADD CONSTRAINT fk_id_riferimento FOREIGN KEY (id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.associativa_riferimenti_categoria DROP CONSTRAINT fk_id_riferimento;
       public          postgres    false    214    3221    220            �           2606    17197 +   autore_riferimento fk_id_riferimento_autore    FK CONSTRAINT     �   ALTER TABLE ONLY public.autore_riferimento
    ADD CONSTRAINT fk_id_riferimento_autore FOREIGN KEY (id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.autore_riferimento DROP CONSTRAINT fk_id_riferimento_autore;
       public          postgres    false    220    3221    216            �           2606    17187 2   associazione_riferimenti fk_id_riferimento_citante    FK CONSTRAINT     �   ALTER TABLE ONLY public.associazione_riferimenti
    ADD CONSTRAINT fk_id_riferimento_citante FOREIGN KEY (id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.associazione_riferimenti DROP CONSTRAINT fk_id_riferimento_citante;
       public          postgres    false    215    3221    220            �           2606    17192 1   associazione_riferimenti fk_id_riferimento_citato    FK CONSTRAINT     �   ALTER TABLE ONLY public.associazione_riferimenti
    ADD CONSTRAINT fk_id_riferimento_citato FOREIGN KEY (id_riferimento_associato) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.associazione_riferimenti DROP CONSTRAINT fk_id_riferimento_citato;
       public          postgres    false    3221    215    220            �           2606    17207    categoria fk_id_super_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_id_super_categoria FOREIGN KEY (id_super_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE SET NULL;
 I   ALTER TABLE ONLY public.categoria DROP CONSTRAINT fk_id_super_categoria;
       public          postgres    false    3213    218    218            �           2606    17202    autore_riferimento fk_id_utente    FK CONSTRAINT     �   ALTER TABLE ONLY public.autore_riferimento
    ADD CONSTRAINT fk_id_utente FOREIGN KEY (id_utente) REFERENCES public.utente(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.autore_riferimento DROP CONSTRAINT fk_id_utente;
       public          postgres    false    222    3225    216            3   G   x�˱�0B���Ȗ�]����k�EC���/><p���6hQFR�E�.�g��w脎>��3      4   K   x�̹0��xY�!��^���MB=^�ӌ���ɉ��t��J5�Y8��+������fS-���6��      5   �   x�U��ACc�
*@����@F�.% �>2K�����O����r���!4�5XEGe�0�؃u�#�@��6Q&W�M,n7�`�p�vz��I��\�iQ����Tz9zC�J7G�M��O������BTJ:���R�������7v�tu�?>�$��v�      7   �  x�UR�n�0</��� ���}TS�H�B[�P䲶z�4(*@�5���XW/���w�*xro>t����H�[�&�D���g"���Q�C@����l"
8����p)Jx�R��NDu�z;�L���m�U��������Ԫ*ay��RJ(�0�Y�ضJ�D�hɖd�	�u���[$|Ց�v��L�	45O��Z��^�̵V�}��a@k��ld���j����ŕ,7�l�N��V/l�����|������0��������H9�4�g����q1K:���M	��[/lر9��<�
������v���~�v�q(�A_8����/������ ����}���L1Z�;�x��v��l������[FjB��4�&��p��j��f%���sX`����|� ��<SȤ      9   V  x����n�@��w�� ��y/QDҋ�F���r�CW2��6A��w\���!�� �������kѴL
���,�f-{��ub��euL�X�<���J�g��:���)��h�T��^�����r�?��T���~f�e�}�]����)�"��n��ۘ��%����q7ף�6�vo�����S�.�Ǧ���*���ᴛ�QuO5���f޶�0�m�h[K\;��gM�O0Θ��a8���8Gd7����O�Ş�:�,?Ų\l��<kc��`դ�{��Q)�6��}��ov���uwu?���}=�E `��c�X;
:
|�C	�8���sz�������A���@�9҅N:C1��6k�u�x>�������N�7��RN���?�пnt��m���8�HA�� f�
�[�0�A+�Zm�HB�%!&�$6��UBk���o�8��0�B�w�M-ll�����%a��x� p㛆`%����@����C7ıoU|/�&�Y��Ҟ�1����9=i��D�E��*G"� �S,�*M�A&�<�f��~�`���P"
u�L��L�`���Z9��s�~C�	��8� o�7      ;   �  x�M�K��0���)��ؙG�t�fP�I�z��l���ʢG���7�9z�R�[�?Q?*�#[�X�t,�����'�A@C6p	�ٓ�X���pTR:�%�1q����g�f�ݶd`��Ny�Wi�G�ᅝ��:�}��P���Һ����|�w�s(�diQk����8�]�96rA�ݭ�Xa)V��I�����:׎���r��`-��AI�BAM�NB5_�Z��j����d��`h���M^�ۏ�V_����mܻ��3,}����`��`��ϴ�G8���t�:��J���C[�m�Lrk[�խO1?r�pu����/"�Ǣ#cFn?����Nk����uM3HP)!?9��uخ�X��x���{�О�P��޻xk��I�'U�6^��~���z�%y��$�?)��     