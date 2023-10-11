<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Forum extends CI_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->database();
        $this->load->helper('string');
        $this->load->model('MKomunitas');
        $this->load->model('MAnggota');
        $this->load->model('MJadwal');
        $this->load->model('MArsip');
        $this->load->model('MAbsensi');
        $this->load->model('MForum');
        if ($this->session->userdata('id') == FALSE) {
            redirect(base_url() . 'masuk');
        }
    }

    public function index()
    {
        // $komunitas = $this->MAnggota->me($this->session->userdata('id'));
        // $thread = [];

        // foreach ($komunitas as $k) {
        //     $raw = $this->MForum->getByMe($k->id_komunitas);
        //     array_push($thread, $raw);
        // }
        // $data['thread'] = $thread;
        $this->db->select('*, thread.id AS id_thread, thread.created_at AS waktu_upload, thread.nama_user AS nama_thread');
        $this->db->where('anggota.id_user', $this->session->userdata('id'));
        $this->db->join('komunitas', 'komunitas.id = thread.id_komunitas');
        $this->db->join('anggota', 'anggota.id_komunitas = komunitas.id');
        $this->db->order_by('waktu_upload', 'DESC');
        $data['thread'] = $this->db->get('thread')->result();

        $top['title'] = "Forum - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('forum/VForum', $data);
        $this->load->view('layouts/Bottom');
    }

    public function create()
    {
        $data['komunitas'] = $this->MAnggota->me($this->session->userdata('id'));
        $top['title'] = "Buat Thread - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('forum/VBuat', $data);
        $this->load->view('layouts/Bottom');
    }

    public function store()
    {
        $komunitas = $this->MKomunitas->cekWithToken($this->input->post('komunitas'))->row_array();
        $data = [
            'id_komunitas' => $komunitas['id'],
            'nama_komunitas' => $komunitas['nama'],
            'token_komunitas' => $komunitas['token'],
            'judul' => $this->input->post('judul'),
            'isi' => $this->input->post('isi'),
            'id_user' => $this->session->userdata('id'),
            'nama_user' => $this->session->userdata('name'),
        ];
        $add = $this->MForum->add($data);
        if ($add) {
            $this->setFlash('success', 'Sukses', 'Thread berhasil dibuat');
            redirect(base_url() . 'forum');
        } else {
            $this->setFlash('warning', 'Error', 'Oops, something error');
            redirect($_SERVER['HTTP_REFERER']);
        }
    }

    public function detail($id_thread)
    {
        $thread = $this->MForum->detail($id_thread);
        $komentar = $this->MForum->komentarByThread($id_thread);

        $data = [
            'thread' => $thread,
            'komentar' => $komentar
        ];

        $top['title'] = "Detail Thread - Komunitas";
        $this->load->view('layouts/Top', $top);
        $this->load->view('layouts/Nav');
        $this->load->view('forum/VDetail', $data);
        $this->load->view('layouts/Bottom');
    }

    public function komentar($id_thread)
    {
        $data = [
            'id_user' => $this->session->userdata('id'),
            'nama_user' => $this->session->userdata('name'),
            'id_thread' => $id_thread,
            'komentar' => $this->input->post('komentar')
        ];
        $add = $this->MForum->addKomentar($data);
        if ($add) {
            $this->setFlash('success', 'Sukses', 'Thread berhasil dibuat');
            redirect($_SERVER['HTTP_REFERER']);
        } else {
            $this->setFlash('warning', 'Error', 'Oops, something error');
            redirect($_SERVER['HTTP_REFERER']);
        }
    }

    private function setFlash($type, $title, $message)
    {
        $this->session->set_flashdata([
            'type' => $type,
            'title' => $title,
            'msg' => $message
        ]);
    }
}
