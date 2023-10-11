<?php
defined('BASEPATH') or exit('No direct script access allowed');

class MKomunitas extends CI_Model
{
    public function add($data)
    {
        return $this->db->insert('komunitas', $data);
    }

    public function cekWithToken($token)
    {
        return $this->db->query("SELECT * FROM komunitas WHERE token='$token'");
    }

    public function cekWithId($id_komunitas)
    {
        $this->db->where('id', $id_komunitas);
        return $this->db->get('komunitas')->result();
    }

    public function delete($id_komunitas)
    {
        $this->db->where('id', $id_komunitas);
        return $this->db->delete('komunitas');
    }

    // public function getAnggota($id_komunitas)
    // {
    //     $query = $this->db->select('*')->from('anggota')->where('id_komunitas', $id_komunitas)->get();
    //     return $query->result();
    // }

    // public function cekAnggota($id_user)
    // {
    //     $query = $this->db->select('*')->from('anggota')->where('id_user', $id_user)->get();
    //     return $query->result();
    // }
}
