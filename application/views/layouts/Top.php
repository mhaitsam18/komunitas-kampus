<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?php echo $title ?></title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fontisto@v3.0.4/css/fontisto/fontisto.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700">
    <link rel="stylesheet" href="<?php echo base_url() ?>assets/vendor/nucleo/css/nucleo.css" type="text/css">
    <link rel="stylesheet" href="<?php echo base_url() ?>assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" type="text/css">
    <link rel="stylesheet" href="<?php echo base_url() ?>assets/css/argon.css?v=1.2.0" type="text/css">

    <script src="<?php echo base_url() ?>assets/vendor/jquery/dist/jquery.min.js"></script>
</head>

<body>
    <?php if ($this->session->flashdata()) { ?>
        <div class="alert alert-la alert-<?php echo $this->session->flashdata('type'); ?> alert-dismissible show" role="alert">
            <span class="alert-text mb-4 mt-3">
                <strong><?php echo $this->session->flashdata('title'); ?></strong> <br>
                <?php echo $this->session->flashdata('msg'); ?>
            </span>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    <?php } ?>