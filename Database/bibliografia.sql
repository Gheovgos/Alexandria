PGDMP     ,    %    	            {           bibliografia    15.1    15.1 :    E           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            F           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            G           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            H           1262    17265    bibliografia    DATABASE        CREATE DATABASE bibliografia WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Italian_Italy.1252';
    DROP DATABASE bibliografia;
                postgres    false            U           1247    17267 	   tipo_enum    TYPE     x   CREATE TYPE public.tipo_enum AS ENUM (
    'Conferenza',
    'Libro',
    'Rivista',
    'Fascicolo',
    'Articolo'
);
    DROP TYPE public.tipo_enum;
       public          postgres    false            �           2605    17387 ,   CAST (public.tipo_enum AS character varying)    CAST     L   CREATE CAST (public.tipo_enum AS character varying) WITH INOUT AS IMPLICIT;
 3   DROP CAST (public.tipo_enum AS character varying);
                   false    853            7           2605    17386 ,   CAST (character varying AS public.tipo_enum)    CAST     L   CREATE CAST (character varying AS public.tipo_enum) WITH INOUT AS IMPLICIT;
 3   DROP CAST (character varying AS public.tipo_enum);
                   false    853            �            1255    17277    articolo_check()    FUNCTION     �   CREATE FUNCTION public.articolo_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Articolo' AND (NEW.ISBN IS NOT NULL OR NEW.DOI IS NOT NULL) THEN
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
       public          postgres    false            �            1255    17279    fascicolo_check()    FUNCTION     /  CREATE FUNCTION public.fascicolo_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Fascicolo' AND (NEW.ISBN IS NOT NULL OR NEW.Editore IS NOT NULL OR NEW.Edizione IS NOT NULL OR NEW.ISNN IS NOT NULL) THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 (   DROP FUNCTION public.fascicolo_check();
       public          postgres    false            �            1255    17280    libro_check()    FUNCTION     �   CREATE FUNCTION public.libro_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Libro' AND NEW.DOI IS NOT NULL THEN
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
       public          postgres    false            �            1255    17282    rivista_check()    FUNCTION     �   CREATE FUNCTION public.rivista_check() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
IF NEW.Tipo = 'Rivista' AND NEW.DOI IS NOT NULL THEN
	RAISE EXCEPTION 'Inserimento non valido';
END IF;
RETURN NEW;
END;
$$;
 &   DROP FUNCTION public.rivista_check();
       public          postgres    false            �            1255    17395    sub_cat(integer)    FUNCTION     �  CREATE FUNCTION public.sub_cat(catin integer) RETURNS SETOF integer
    LANGUAGE plpgsql
    AS $$

DECLARE
codice integer;
codiciString VARCHAR(100) := '';
catTmp integer := catIn;
i record;
BEGIN
FOR codice IN SELECT id_categoria FROM CATEGORIA WHERE super_categoria_id_categoria = catIn LOOP
RETURN NEXT codice;
RETURN QUERY SELECT sub_cat FROM sub_cat(codice);
END LOOP;
RETURN;
END;
$$;
 -   DROP FUNCTION public.sub_cat(catin integer);
       public          postgres    false            �            1255    17388    super_cat(integer)    FUNCTION     �  CREATE FUNCTION public.super_cat(catin integer) RETURNS TABLE(codice integer)
    LANGUAGE plpgsql
    AS $$
DECLARE
arrayID integer[];
codiciString VARCHAR(100) := '';
catTmp integer := catIn;
supercatTmp integer := (SELECT super_categoria_id_categoria FROM Categoria WHERE id_categoria = catTmp);
BEGIN
WHILE supercatTmp IS NOT NULL
BEGIN LOOP
	arrayID := array_append(arrayID, supercatTmp);
	catTmp := supercatTmp;
	supercatTmp := (SELECT super_categoria_id_categoria FROM Categoria WHERE ID_Categoria = catTmp);
END LOOP;
IF array_length(arrayID, 1) IS NOT NULL THEN
FOREACH codice IN ARRAY arrayID LOOP
RETURN NEXT;
END LOOP;
END IF;
RETURN;
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
            public          postgres    false    215            �            1259    17296    riferimenti_biblio    TABLE     
  CREATE TABLE public.riferimenti_biblio (
    id_riferimento integer NOT NULL,
    titolo_riferimento character varying(200) NOT NULL,
    data_riferimento date,
    on_line boolean NOT NULL,
    tipo public.tipo_enum NOT NULL,
    url character varying(500),
    doi integer,
    descrizione character varying(1000),
    editore character varying(1000),
    isbn character varying(20),
    isnn character varying(20),
    luogo character varying(100),
    pag_inizio integer,
    pag_fine integer,
    edizione integer
);
 &   DROP TABLE public.riferimenti_biblio;
       public         heap    postgres    false    853            �            1259    17305    riferimenti_biblio_categorie    TABLE     �   CREATE TABLE public.riferimenti_biblio_categorie (
    riferimento_id_riferimento integer NOT NULL,
    categorie_id_categoria integer NOT NULL
);
 0   DROP TABLE public.riferimenti_biblio_categorie;
       public         heap    postgres    false            �            1259    17301 %   riferimenti_biblio_id_riferimento_seq    SEQUENCE     �   ALTER TABLE public.riferimenti_biblio ALTER COLUMN id_riferimento ADD GENERATED BY DEFAULT AS IDENTITY (
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
       public         heap    postgres    false            �            1259    17285    riferimenti_biblio_user_id    TABLE     �   CREATE TABLE public.riferimenti_biblio_user_id (
    utente_user_id integer NOT NULL,
    riferimento_id_riferimento integer NOT NULL
);
 .   DROP TABLE public.riferimenti_biblio_user_id;
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
       public         heap    postgres    false            �            1259    17313    utente_id_utente_seq    SEQUENCE     �   ALTER TABLE public.utente ALTER COLUMN user_id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.utente_id_utente_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    221            ;          0    17290 	   categoria 
   TABLE DATA           i   COPY public.categoria (id_categoria, descr_categoria, super_categoria_id_categoria, user_id) FROM stdin;
    public          postgres    false    215   X       =          0    17296    riferimenti_biblio 
   TABLE DATA           �   COPY public.riferimenti_biblio (id_riferimento, titolo_riferimento, data_riferimento, on_line, tipo, url, doi, descrizione, editore, isbn, isnn, luogo, pag_inizio, pag_fine, edizione) FROM stdin;
    public          postgres    false    217   �Y       @          0    17305    riferimenti_biblio_categorie 
   TABLE DATA           j   COPY public.riferimenti_biblio_categorie (riferimento_id_riferimento, categorie_id_categoria) FROM stdin;
    public          postgres    false    220   �]       ?          0    17302 &   riferimenti_biblio_riferimento_citante 
   TABLE DATA           �   COPY public.riferimenti_biblio_riferimento_citante (riferimento_citato_id_riferimento, riferimento_citante_id_riferimento) FROM stdin;
    public          postgres    false    219   >^       :          0    17285    riferimenti_biblio_user_id 
   TABLE DATA           `   COPY public.riferimenti_biblio_user_id (utente_user_id, riferimento_id_riferimento) FROM stdin;
    public          postgres    false    214   �^       A          0    17308    utente 
   TABLE DATA           `   COPY public.utente (user_id, username, nome, cognome, password_hashed, salt, email) FROM stdin;
    public          postgres    false    221   _       I           0    0    categoria_id_categoria_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.categoria_id_categoria_seq', 1, false);
          public          postgres    false    216            J           0    0 %   riferimenti_biblio_id_riferimento_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('public.riferimenti_biblio_id_riferimento_seq', 53, true);
          public          postgres    false    218            K           0    0    utente_id_utente_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.utente_id_utente_seq', 36, true);
          public          postgres    false    222            �           2606    17315 f   riferimenti_biblio_riferimento_citante associazione_riferimenti_id_riferimento_id_riferimento_asso_key 
   CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT associazione_riferimenti_id_riferimento_id_riferimento_asso_key UNIQUE (riferimento_citato_id_riferimento, riferimento_citante_id_riferimento);
 �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT associazione_riferimenti_id_riferimento_id_riferimento_asso_key;
       public            postgres    false    219    219            �           2606    17319 2   riferimenti_biblio_user_id autore_riferimento_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_user_id
    ADD CONSTRAINT autore_riferimento_pkey PRIMARY KEY (utente_user_id, riferimento_id_riferimento);
 \   ALTER TABLE ONLY public.riferimenti_biblio_user_id DROP CONSTRAINT autore_riferimento_pkey;
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
       public          postgres    false    217    223    217            �           2620    17339 #   riferimenti_biblio conferenza_check    TRIGGER     �   CREATE TRIGGER conferenza_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.conferenza_check();
 <   DROP TRIGGER conferenza_check ON public.riferimenti_biblio;
       public          postgres    false    217    224    217            �           2620    17340 "   riferimenti_biblio fascicolo_check    TRIGGER     �   CREATE TRIGGER fascicolo_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.fascicolo_check();
 ;   DROP TRIGGER fascicolo_check ON public.riferimenti_biblio;
       public          postgres    false    227    217    217            �           2620    17341    riferimenti_biblio libro_check    TRIGGER     �   CREATE TRIGGER libro_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.libro_check();
 7   DROP TRIGGER libro_check ON public.riferimenti_biblio;
       public          postgres    false    225    217    217            �           2620    17342    riferimenti_biblio online_check    TRIGGER     �   CREATE TRIGGER online_check AFTER INSERT OR UPDATE OF on_line ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.online_check();
 8   DROP TRIGGER online_check ON public.riferimenti_biblio;
       public          postgres    false    217    226    217            �           2620    17343     riferimenti_biblio rivista_check    TRIGGER     �   CREATE TRIGGER rivista_check AFTER INSERT OR UPDATE OF tipo ON public.riferimenti_biblio FOR EACH ROW EXECUTE FUNCTION public.rivista_check();
 9   DROP TRIGGER rivista_check ON public.riferimenti_biblio;
       public          postgres    false    228    217    217            �           2606    17344 ,   riferimenti_biblio_categorie fk_id_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_categorie
    ADD CONSTRAINT fk_id_categoria FOREIGN KEY (categorie_id_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE CASCADE;
 V   ALTER TABLE ONLY public.riferimenti_biblio_categorie DROP CONSTRAINT fk_id_categoria;
       public          postgres    false    215    220    3213            �           2606    17349     categoria fk_id_categoria_utente    FK CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_id_categoria_utente FOREIGN KEY (user_id) REFERENCES public.utente(user_id) ON UPDATE CASCADE ON DELETE SET NULL;
 J   ALTER TABLE ONLY public.categoria DROP CONSTRAINT fk_id_categoria_utente;
       public          postgres    false    3227    215    221            �           2606    17354 .   riferimenti_biblio_categorie fk_id_riferimento    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_categorie
    ADD CONSTRAINT fk_id_riferimento FOREIGN KEY (riferimento_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 X   ALTER TABLE ONLY public.riferimenti_biblio_categorie DROP CONSTRAINT fk_id_riferimento;
       public          postgres    false    3221    220    217            �           2606    17359 3   riferimenti_biblio_user_id fk_id_riferimento_autore    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_user_id
    ADD CONSTRAINT fk_id_riferimento_autore FOREIGN KEY (riferimento_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.riferimenti_biblio_user_id DROP CONSTRAINT fk_id_riferimento_autore;
       public          postgres    false    217    3221    214            �           2606    17364 @   riferimenti_biblio_riferimento_citante fk_id_riferimento_citante    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT fk_id_riferimento_citante FOREIGN KEY (riferimento_citato_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 j   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT fk_id_riferimento_citante;
       public          postgres    false    217    3221    219            �           2606    17369 ?   riferimenti_biblio_riferimento_citante fk_id_riferimento_citato    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante
    ADD CONSTRAINT fk_id_riferimento_citato FOREIGN KEY (riferimento_citante_id_riferimento) REFERENCES public.riferimenti_biblio(id_riferimento) ON UPDATE CASCADE ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.riferimenti_biblio_riferimento_citante DROP CONSTRAINT fk_id_riferimento_citato;
       public          postgres    false    217    219    3221            �           2606    17374    categoria fk_id_super_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT fk_id_super_categoria FOREIGN KEY (super_categoria_id_categoria) REFERENCES public.categoria(id_categoria) ON UPDATE CASCADE ON DELETE SET NULL;
 I   ALTER TABLE ONLY public.categoria DROP CONSTRAINT fk_id_super_categoria;
       public          postgres    false    215    3213    215            �           2606    17379 '   riferimenti_biblio_user_id fk_id_utente    FK CONSTRAINT     �   ALTER TABLE ONLY public.riferimenti_biblio_user_id
    ADD CONSTRAINT fk_id_utente FOREIGN KEY (utente_user_id) REFERENCES public.utente(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 Q   ALTER TABLE ONLY public.riferimenti_biblio_user_id DROP CONSTRAINT fk_id_utente;
       public          postgres    false    3227    214    221            ;   �  x�UR�n�0</��� �(J�}tSWH�BZ�P䲶� �5(*@�5���XW/����C�*x�oZ������H�g�`G���G�f���hb4cP>Dt�t69Y�i<\��/�]F'b�����:��m�k#v�G�ƙnT�\����<J)�|È'd�b�*���M�Mceme�	ض�a���&Z�>�2i՞��VP�j���*��'��9㈍T�R��b���ƅ,V��]���-:3����6��~�;�`՟x!?�T�!��+�~"�d�y�w�p>IZ�M𳦀�K5��lΞY�neot�/�^�{�-ܖco<�2�3�35w������/H�v�b�-mOc��v-A6�Sxa7+�n�`��1R#ʡ4��M����lm����]cNa��lC~O�-<S��c�D�
�y�ܰ��V�D�,bYr4�����!^�L�~B����D      =   �  x��VMo�6=S��=���/��-�4�ƻM�={ad�& �.%9@~M����vhQ��i-`ز�y�f�=R�i��ќ�E.9G-�h��G����7������x�,F\Vzev��i$Y�	��?,�	��ïѕwk�{�qY)Krv+����N�f,��)�����ׯS�J�N�c\%��E��@�'\>�}�۴�GX}�|x�FTޣ�P��ZLQotS�/]`"J����	_v�W&d9cj�%|��1t_������5�^u�n�w���`��L�,��Q.�����~�^�}W���[����X��DR����ET�h��#�����9�S� ��a~��r%�4�B�2#$��1G�!R�!b��.��{�m��n�o���Hq�)�t�g$����z�2�,���v�j��B�Yz V�c�� Έ�"�Z�"#�,d�Y���BN�>��(h��®�2"��G�"�DyFX$`�Ӂ/=�M6$3m���6$�`	��D�I>$3|��� ��8{0���n�cۭ��q*%��t��H�5bAaK;3"�xok��Tɉd��XE�:k��D�r�:���MN����R�'q���RIY������j�����+��/�{Z���N�`�:��T썩�`���e^�9�Li	L�s��H�y;�O&�)	G76��,R�,�T�ט��I"�$j�6ƘC��cm�����a}1�s<��f�����i���&��;��݅m���M�ՑR�~���`_�o�].�+�q5`����W �
+�@u��I)�/�O�Ȇ����#��4�i�UBb�T�xg~��U� 5\Y��4v����	���ǿ�Ⱥ>���i<�V����]̓$�qZL��3��mgWǶ<�}Їlqב���B�4�6���X����?:p��>`��m�5^�n��ׯs|����ŭv��m� ��%��(4c����t$�lm��>t��|0���!J�d��u�ㄾ^dY�cZ�7      @   U   x�5���@Bk&:��]�����Q BX44�\�憃^�aSA�T ���f���QzT9;��A������,��\$_���      ?   V   x���!���b~�1z�����%%b8���ٶE����Mç�fj�쒥k��TW��pU��tne9K�>_�Q�띿x~��ة�      :   `   x�%���0C�31S��K��c��B�h%�N�
����ɖGN�䃭��z�l|�ƥ<5�ex��u�h��V��>���U����S9�N5#y~�G8&      A   b  x�MT�n�6}E����u�l��Y'i�$]l��u�DJ�L�2Eɒ�����r���C��̙	`U�� O�ij���χ#7v���$�\(q�����v��;�CF�l��v%WVd��)��d���*��ဧc�;�*21<��
xB�p���0�r�(�2\Dsg2�&�;F�^�\�5�FC�fz-H�<�Z��u6	��mӠP�N	Ϣ���zН�aW�"u�s��@�V�Tx���Z5��K��ؼ��2̄�kM&Xix2���v�!aT��˜�:�Ԁ�#d.ĵVZ�����>�N�0��m,�}k�p7Jp�3�H�8���4�����/A O��	��n��;�F��N�
�x:i'���bW�po��ږ�{�r(�2nR1��(:$��#X��t�{xt�׺i|G>����<U�W)�5�5��?��T�'��t���3j�����.H4�����%�����1�����VJ��g�{P8�QC�����	�T���#JY�-��9���F
�������c"�Ľ:y(y�j��s��;:��?���S���zB�C��#�%��H���\�_��B�_#�Cj�9��s��C�6V����(���s�A����Mb��+�B:Q�^�B�h��/A�qN��oC+^��f�lX�]c^ڽŢ�l����b�k�|w��#�W��i4�
�$	�i2��(���H���M��}���H����L�R�kN���,\Fa$S�/LȚe�k/�V�pr��$� �C���$\̂y����L����~���
�w.�h=��M�w1"�%���l��tY����O�z�6�����B^�$Y�$�&Q���n^�Z�a�ܔ9�=��;�����"�.��Ǳ���=Z�-J�%L�@3-3At���4���ws'��_n�ř_�aO�$�9�͇<��~��������ЦØ�%�ŕ��$��,�55*�p�f�T�_��l1���%텭�2n��}�ϏG�"�m.����9�I4����FF|���`���V�VHדy4]�	�����3� �x}��W��-��$J(!��Z*���P�C˕�P���0\�`te�������"�����d2���U�     