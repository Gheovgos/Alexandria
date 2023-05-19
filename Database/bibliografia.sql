PGDMP         	                {           bibliografia    15.1    15.1 8    C           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            D           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            E           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            F           1262    17265    bibliografia    DATABASE        CREATE DATABASE bibliografia WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';
    DROP DATABASE bibliografia;
                postgres    false            U           1247    17267 	   tipo_enum    TYPE     x   CREATE TYPE public.tipo_enum AS ENUM (
    'Conferenza',
    'Libro',
    'Rivista',
    'Fascicolo',
    'Articolo'
);
    DROP TYPE public.tipo_enum;
       public          postgres    false            �            1255    17277    articolo_check()    FUNCTION     E  CREATE FUNCTION public.articolo_check() RETURNS trigger
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
       public          postgres    false            �            1255    17278    conferenza_check()    FUNCTION     �  CREATE FUNCTION public.conferenza_check() RETURNS trigger
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
       public          postgres    false            �            1255    17279    fascicolo_check()    FUNCTION     �  CREATE FUNCTION public.fascicolo_check() RETURNS trigger
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
       public          postgres    false            �            1255    17280    libro_check()    FUNCTION     B  CREATE FUNCTION public.libro_check() RETURNS trigger
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
       public          postgres    false            �            1255    17281    online_check()    FUNCTION     �   CREATE FUNCTION public.online_check() RETURNS trigger
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
       public          postgres    false            �            1255    17282    rivista_check()    FUNCTION     ~  CREATE FUNCTION public.rivista_check() RETURNS trigger
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
       public          postgres    false            �            1255    17283    sub_cat(integer)    FUNCTION     �  CREATE FUNCTION public.sub_cat(catin integer) RETURNS character varying
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
       public          postgres    false            �            1255    17284    super_cat(integer)    FUNCTION     +  CREATE FUNCTION public.super_cat(catin integer) RETURNS character varying
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
       public          postgres    false            �            1259    17290 	   categoria    TABLE     �   CREATE TABLE public.categoria (
    id_categoria integer NOT NULL,
    descr_categoria character varying(500) NOT NULL,
    super_categoria_id_categoria integer,
    user_id integer
);
    DROP TABLE public.categoria;
       public         heap    postgres    false            �            1259    17295    categoria_id_categoria_seq    SEQUENCE     �   ALTER TABLE public.categoria ALTER COLUMN id_categoria ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.categoria_id_categoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    215            �            1259    17296    riferimenti_biblio    TABLE       CREATE TABLE public.riferimenti_biblio (
    id_riferimento integer NOT NULL,
    titolo_riferimento character varying(200) NOT NULL,
    data_riferimento date,
    on_line boolean NOT NULL,
    tipo public.tipo_enum NOT NULL,
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
       public         heap    postgres    false    853            �            1259    17301 %   riferimenti_biblio_id_riferimento_seq    SEQUENCE     �   ALTER TABLE public.riferimenti_biblio ALTER COLUMN id_riferimento ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.riferimenti_biblio_id_riferimento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    217            �            1259    17302 &   riferimenti_biblio_riferimento_citante    TABLE     �   CREATE TABLE public.riferimenti_biblio_riferimento_citante (
    riferimento_citato_id_riferimento integer NOT NULL,
    riferimento_citante_id_riferimento integer NOT NULL
);
 :   DROP TABLE public.riferimenti_biblio_riferimento_citante;
       public         heap    postgres    false            �            1259    17305    riferimento_biblio_categorie    TABLE     �   CREATE TABLE public.riferimento_biblio_categorie (
    riferimento_id_riferimento integer NOT NULL,
    categorie_id_categoria integer NOT NULL
);
 0   DROP TABLE public.riferimento_biblio_categorie;
       public         heap    postgres    false            �            1259    17308    utente    TABLE     /  CREATE TABLE public.utente (
    user_id integer NOT NULL,
    username character varying(20) NOT NULL,
    nome character varying(200) NOT NULL,
    cognome character varying(200) NOT NULL,
    password_hashed character varying(500),
    salt character varying(500),
    email character varying(50)
);
    DROP TABLE public.utente;
       public         heap    postgres    false            �            1259    17285    utente_id_riferimento    TABLE     �   CREATE TABLE public.utente_id_riferimento (
    utente_user_id integer NOT NULL,
    id_riferimento_id_riferimento integer NOT NULL
);
 )   DROP TABLE public.utente_id_riferimento;
       public         heap    postgres    false            �            1259    17313    utente_id_utente_seq    SEQUENCE     �   ALTER TABLE public.utente ALTER COLUMN user_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.utente_id_utente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221            9          0    17290 	   categoria 
   TABLE DATA           i   COPY public.categoria (id_categoria, descr_categoria, super_categoria_id_categoria, user_id) FROM stdin;
    public          postgres    false    215   6W       ;          0    17296    riferimenti_biblio 
   TABLE DATA           �   COPY public.riferimenti_biblio (id_riferimento, titolo_riferimento, data_riferimento, on_line, tipo, url, doi, descr_riferimento, editore, isbn, isnn, luogo, pag_inizio, pag_fine, edizione) FROM stdin;
    public          postgres    false    217   �X       =          0    17302 &   riferimenti_biblio_riferimento_citante 
   TABLE DATA           �   COPY public.riferimenti_biblio_riferimento_citante (riferimento_citato_id_riferimento, riferimento_citante_id_riferimento) FROM stdin;
    public          postgres    false    219   N[       >          0    17305    riferimento_biblio_categorie 
   TABLE DATA           j   COPY public.riferimento_biblio_categorie (riferimento_id_riferimento, categorie_id_categoria) FROM stdin;
    public          postgres    false    220   �[       ?          0    17308    utente 
   TABLE DATA           `   COPY public.utente (user_id, username, nome, cognome, password_hashed, salt, email) FROM stdin;
    public          postgres    false    221    \       8          0    17285    utente_id_riferimento 
   TABLE DATA           ^   COPY public.utente_id_riferimento (utente_user_id, id_riferimento_id_riferimento) FROM stdin;
    public          postgres    false    214   n_       G           0    0    categoria_id_categoria_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 1, false);
          public          postgres    false    216            H           0    0 %   riferimenti_biblio_id_riferimento_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.riferimenti_biblio_id_riferimento_seq', 1, false);
          public          postgres    false    218            I           0    0    utente_id_utente_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.utente_id_utente_seq', 31, true);
          public          postgres    false    222            �           2606    17315 f   riferimenti_biblio_riferimento_citante associazione_riferimenti_id_riferimento_id_riferimento_asso_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT associazione_riferimenti_id_riferimento_id_riferimento_asso_key UNIQUE (riferimento_citato_id_riferimento, riferimento_citante_id_riferimento);
 �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT associazione_riferimenti_id_riferimento_id_riferimento_asso_key;
       public            postgres    false    219    219            �           2606    17319 -   utente_id_riferimento autore_riferimento_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.utente_id_riferimento
    ADD CONSTRAINT autore_riferimento_pkey PRIMARY KEY (utente_user_id, id_riferimento_id_riferimento);
 W   ALTER TABLE ONLY public.utente_id_riferimento DROP CONSTRAINT autore_riferimento_pkey;
       public            postgres    false    214    214            �           2606    17321 7   categoria categoria_id_categoria_id_super_categoria_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_id_categoria_id_super_categoria_key UNIQUE (id_categoria, super_categoria_id_categoria);
 a   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_id_categoria_id_super_categoria_key;
       public            postgres    false    215    215            �           2606    17323    categoria categoria_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria);
 B   ALTER TABLE ONLY public.categoria DROP CONSTRAINT categoria_pkey;
       public            postgres    false    215            �           2606    17325 -   riferimenti_biblio riferimenti_biblio_doi_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_doi_key UNIQUE (doi);
 W   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_doi_key;
       public            postgres    false    217            �           2606    17327 .   riferimenti_biblio riferimenti_biblio_isbn_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_isbn_key UNIQUE (isbn);
 X   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_isbn_key;
       public            postgres    false    217            �           2606    17329 .   riferimenti_biblio riferimenti_biblio_isnn_key 
   CONSTRAINT     i   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_isnn_key UNIQUE (isnn);
 X   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_isnn_key;
       public            postgres    false    217            �           2606    17331 *   riferimenti_biblio riferimenti_biblio_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_pkey PRIMARY KEY (id_riferimento);
 T   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_pkey;
       public            postgres    false    217            �           2606    17333 -   riferimenti_biblio riferimenti_biblio_url_key 
   CONSTRAINT     g   ALTER TABLE ONLY public.riferimenti_biblio
    ADD CONSTRAINT riferimenti_biblio_url_key UNIQUE (url);
 W   ALTER TABLE ONLY public.riferimenti_biblio DROP CONSTRAINT riferimenti_biblio_url_key;
       public            postgres    false    217            �           2606    17335    utente utente_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (user_id);
 <   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_pkey;
       public            postgres    false    221            �           2606    17337    utente utente_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_username_key;
       public            postgres    false    221            �           2620    17338 !   riferimenti_biblio articolo_check    TRIGGER     �   CREATE TRIGGER articolo_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.articolo_check();
 :   DROP TRIGGER articolo_check ON public.riferimenti_biblio;
       public          postgres    false    217    217    223            �           2620    17339 #   riferimenti_biblio conferenza_check    TRIGGER     �   CREATE TRIGGER conferenza_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.conferenza_check();
 <   DROP TRIGGER conferenza_check ON public.riferimenti_biblio;
       public          postgres    false    217    224    217            �           2620    17340 "   riferimenti_biblio fascicolo_check    TRIGGER     �   CREATE TRIGGER fascicolo_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.fascicolo_check();
 ;   DROP TRIGGER fascicolo_check ON public.riferimenti_biblio;
       public          postgres    false    225    217    217            �           2620    17341    riferimenti_biblio libro_check    TRIGGER     �   CREATE TRIGGER libro_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.libro_check();
 7   DROP TRIGGER libro_check ON public.riferimenti_biblio;
       public          postgres    false    226    217    217            �           2620    17342    riferimenti_biblio online_check    TRIGGER     �   CREATE TRIGGER online_check AFTER INSERT OR UPDATE OF on_line ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.online_check();
 8   DROP TRIGGER online_check ON public.riferimenti_biblio;
       public          postgres    false    217    227    217            �           2620    17343     riferimenti_biblio rivista_check    TRIGGER     �   CREATE TRIGGER rivista_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.rivista_check();
 9   DROP TRIGGER rivista_check ON public.riferimenti_biblio;
       public          postgres    false    217    217    228            �           2606    17344 ,   riferimento_biblio_categorie fk_id_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimento_biblio_categorie
    ADD CONSTRAINT fk_id_categoria FOREIGN KEY (categorie_id_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.riferimento_biblio_categorie DROP CONSTRAINT fk_id_categoria;
       public          postgres    false    220    215    3211            �           2606    17349     categoria fk_id_categoria_utente    FK CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_id_categoria_utente FOREIGN KEY (user_id) REFERENCES public.utente(user_id) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.categoria DROP CONSTRAINT fk_id_categoria_utente;
       public          postgres    false    221    215    3225            �           2606    17354 .   riferimento_biblio_categorie fk_id_riferimento    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimento_biblio_categorie
    ADD CONSTRAINT fk_id_riferimento FOREIGN KEY (riferimento_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.riferimento_biblio_categorie DROP CONSTRAINT fk_id_riferimento;
       public          postgres    false    220    217    3219            �           2606    17359 .   utente_id_riferimento fk_id_riferimento_autore    FK CONSTRAINT     �   ALTER TABLE ONLY public.utente_id_riferimento
    ADD CONSTRAINT fk_id_riferimento_autore FOREIGN KEY (id_riferimento_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.utente_id_riferimento DROP CONSTRAINT fk_id_riferimento_autore;
       public          postgres    false    214    3219    217            �           2606    17364 @   riferimenti_biblio_riferimento_citante fk_id_riferimento_citante    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT fk_id_riferimento_citante FOREIGN KEY (riferimento_citato_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT fk_id_riferimento_citante;
       public          postgres    false    3219    219    217            �           2606    17369 ?   riferimenti_biblio_riferimento_citante fk_id_riferimento_citato    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT fk_id_riferimento_citato FOREIGN KEY (riferimento_citante_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT fk_id_riferimento_citato;
       public          postgres    false    219    217    3219            �           2606    17374    categoria fk_id_super_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_id_super_categoria FOREIGN KEY (super_categoria_id_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE SET NULL;
 I   ALTER TABLE ONLY public.categoria DROP CONSTRAINT fk_id_super_categoria;
       public          postgres    false    215    3211    215            �           2606    17379 "   utente_id_riferimento fk_id_utente    FK CONSTRAINT     �   ALTER TABLE ONLY public.utente_id_riferimento
    ADD CONSTRAINT fk_id_utente FOREIGN KEY (utente_user_id) REFERENCES public.utente(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 L   ALTER TABLE ONLY public.utente_id_riferimento DROP CONSTRAINT fk_id_utente;
       public          postgres    false    3225    214    221            9   �  x�UR�n�0</��� ���}TS�H�B[�P䲶z�4(*@�5���XW/���w�*xro>t����H�[�&�D���g"���Q�C@����l"
8����p)Jx�R��NDu�z;�L���m�U��������Ԫ*ay��RJ(�0�Y�ضJ�D�hɖd�	�u���[$|Ց�v��L�	45O��Z��^�̵V�}��a@k��ld���j����ŕ,7�l�N��V/l�����|������0��������H9�4�g����q1K:���M	��[/lر9��<�
������v���~�v�q(�A_8����/������ ����}���L1Z�;�x��v��l������[FjB��4�&��p��j��f%���sX`����|� ��<SȤ      ;   V  x����n�@��w�� ��y/QDҋ�F���r�CW2��6A��w\���!�� �������kѴL
���,�f-{��ub��euL�X�<���J�g��:���)��h�T��^�����r�?��T���~f�e�}�]����)�"��n��ۘ��%����q7ף�6�vo�����S�.�Ǧ���*���ᴛ�QuO5���f޶�0�m�h[K\;��gM�O0Θ��a8���8Gd7����O�Ş�:�,?Ų\l��<kc��`դ�{��Q)�6��}��ov���uwu?���}=�E `��c�X;
:
|�C	�8���sz�������A���@�9҅N:C1��6k�u�x>�������N�7��RN���?�пnt��m���8�HA�� f�
�[�0�A+�Zm�HB�%!&�$6��UBk���o�8��0�B�w�M-ll�����%a��x� p㛆`%����@����C7ıoU|/�&�Y��Ҟ�1����9=i��D�E��*G"� �S,�*M�A&�<�f��~�`���P"
u�L��L�`���Z9��s�~C�	��8� o�7      =   K   x�̹0��xY�!��^���MB=^�ӌ���ɉ��t��J5�Y8��+������fS-���6��      >   G   x�˱�0B���Ȗ�]����k�EC���/><p���6hQFR�E�.�g��w脎>��3      ?   ^  x�ETmr�8�ݜ"�6�����[5d���T%��l���,I6�7�s�Ŷe���
�E��x�� �9:��G[k+��=�/ܸ��IG�D/�3�=�a7����!g�<Q�{%WNd��)��j���Z�\Fp��b�AE�3�W�?�eB��4�p9[x�l�-�:�Qx�p	���J+��V�)8E��h:�11|Ӎ�(�{F��G|�G������_��Dg�fF��;����U�i�����v@,!�L���J�����xd�-G�J��{���Lu��2R�Sl��RX"�\�Y��)�u���x��i��`�3�H�8�����X��b�K��ׅ0��ݩ4J��5&��7�gǼ(;g����j��!�yy��7�M�����3��q��+<��[m�0�QO��~b%O���>ź�E"����_�j���cݟ����F�%�3{�����j�
���<n�W���Z���T���^m4Ѓ�3ݢ��Ke�I�avn0o�456J@��oj �0ˆ{DxR�c	%�|/�t�|E/S���^O��=̈́�c{5�� �>	�A�&�~�k�s�+�!EJ���$�T�P{8�i�X�jX]�XF��~��ʦ��e�D�$t�S�t���r��a>�8�fᔆ��5�-�n�$aWl�ymN�k�a�G��~��./���ZM�� ��x/�����a�>�Ir}����#&��P�[N�n�fa�Sp�LȚel�^�N�rr�F�D��;��"a� ��`A�ֽ�)���ʿ��/+�߸�\��S~�|����O�"���%�s����}���T��}�	4V!?�&9�'�&��d2��D��      8   I   x���� ���K1�(`/�_�pN�t*7=w�I1R�+6�ر���:��m����p�v�jg�.����     