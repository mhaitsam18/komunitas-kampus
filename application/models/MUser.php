<?php
defined('BASEPATH') or exit('No direct script access allowed');

class MUser extends CI_Model
{
    public function add($data)
    {
        $this->db->insert('user', $data);
        return $this->db->insert('organisasi', [
            'id_pengurus' => $this->db->insert_id(),
            'logo' => 'default.png'
        ]);
        
    }

    public function cekuser($email, $password)
    {
        $hasil = $this->db->query("SELECT * FROM user WHERE email='$email' AND password='$password'");
        return $hasil;
    }

    public function cekWithEmail($email)
    {
        $hasil = $this->db->query("SELECT * FROM user WHERE email='$email'");
        return $hasil;
    }

    public function update($data, $idu)
    {
        $hasil = $this->db->update('user', $data, 'id=' . $idu);
        return $hasil;
    }

    public function anggota($id_user)
    {
        $this->db->where('id', $id_user);
        return $this->db->get('user')->result();
    }
}
