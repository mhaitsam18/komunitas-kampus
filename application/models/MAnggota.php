<?php
defined('BASEPATH') or exit('No direct script access allowed');

class MAnggota extends CI_Model
{
    public function me($id_user)
    {
        $this->db->select('*, anggota.id AS id_anggota');
        $this->db->from('anggota');
        $this->db->where('id_user', $id_user);
        $this->db->join('komunitas', 'komunitas.id = anggota.id_komunitas');
        return $this->db->get()->result();
    }

    public function me_admin($id_user)
    {
        $this->db->select('*, anggota.id AS id_anggota');
        $this->db->from('anggota');
        $this->db->where('id_user', $id_user);
        $this->db->where('is_admin', 1);
        $this->db->join('komunitas', 'komunitas.id = anggota.id_komunitas');
        return $this->db->get()->result();
    }

    public function meWithoutJoin($id_user)
    {
        $this->db->select('*');
        $this->db->from('anggota');
        $this->db->where('id_user', $id_user);
        return $this->db->get()->result();
    }

    public function cekAdmin($id_user, $token_komunitas)
    {
        $this->db->where('id_user', $id_user);
        $this->db->where('token_komunitas', $token_komunitas);
        $this->db->where('is_admin', '1');
        return $this->db->get('anggota')->result();
    }

    public function getAnggota($token)
    {
        $this->db->where('token_komunitas', $token);
        return $this->db->get('anggota')->result();
    }

    public function getAnggotaByIdKomunitas($id_komunitas)
    {
        $this->db->where('token_komunitas', $id_komunitas);
        return $this->db->get('anggota')->result();
    }

    public function setAnggota($data, $id)
    {
        $hasil = $this->db->update('anggota', $data, 'id=' . $id);
        return $hasil;
    }

    public function addAnggota($data)
    {
        return $this->db->insert('anggota', $data);
    }

    public function getAnggotaById($id_komunitas, $id_user)
    {
        $hasil = $this->db->query("SELECT * FROM anggota WHERE id_komunitas='$id_komunitas' AND id_user='$id_user'");
        return $hasil;
    }

    public function delete($id_anggota)
    {
        $this->db->where('id', $id_anggota);
        return $this->db->delete('anggota');
    }
}
